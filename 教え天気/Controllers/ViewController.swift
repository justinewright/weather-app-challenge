//
//  ViewController.swift
//  pageViewControllerDemo
//
//  Created by Justine Wright on 2021/09/05.
//

import UIKit
import CoreLocation
import Combine

class ViewController: UIPageViewController {

    private var pages = [UIViewController]()
    private var searchTextField: UITextField!
    private var locationRepo = LocationRepo.shared

    private var cancellables: Set<AnyCancellable> = []
    private var currentLocationName: String = ""
    private var locationManager: AnyCancellable!
    private var repoWatcher: AnyCancellable!

    private var isLoading = true
    private var doneLoading =  PassthroughSubject<Bool, Never>()
    private var addedCityNames: [String] = []
    let cityNamesPublisher = PassthroughSubject<[String], Never>()

    lazy var loadingScreen: UINavigationController = {
        let navVC = UINavigationController(rootViewController: emptyView)
        navVC.modalPresentationStyle = .overFullScreen
        return navVC
    }()

    lazy var emptyView: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .black
        return vc
    }()

    private lazy var currentLocationVC: WeatherViewController = {
        let vc = WeatherViewController()
        return vc
        
    }()

    private func specificLocationVC(coordinates: CLLocationCoordinate2D) -> WeatherViewController {
        let vc = WeatherViewController(viewModel: MainViewModel(
                                        repository: Repository(weatherApiClient: OpenWeatherMapsApiClient(),
                                                               coordinates: coordinates)))
        return  vc
    }

    lazy var showListButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(presentLocationList), for: .touchUpInside)
        return button
    }()

    private let pageControl = UIPageControl()
    private let initialPage = 0

    required init?(coder: NSCoder) {
        super.init(transitionStyle:.scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    func refresh() {
        viewDidLoad()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
    }

    @objc func presentLocationList() {
        let vc = UIViewController()
        let locView = LocationCollectionView()
        vc.view = locView
        vc.title = "Locations"
  
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .overFullScreen

        present(navVC, animated: true, completion: nil)

        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:  #selector(self.addPressed))
        add.tintColor = .white
        vc.navigationItem.rightBarButtonItem = add
        vc.view.addSubview(searchTextField)

        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        searchTextField.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        searchTextField.placeholder = "<City name>, <Country name>"
        searchTextField.isHidden = true

        locView.callback = { _ -> Void in
            navVC.dismiss(animated: true, completion: nil)
        }
    }

    func presentLoadingScreen() {
        present(loadingScreen, animated: false, completion: nil)
    }
    
    func hideLoadingScreen() {
        loadingScreen.dismiss(animated: false, completion: nil)
    }
}

extension ViewController {
    func setupView() {
        dataSource = self
        delegate = self

        view.addSubview(showListButton)
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)

        searchTextField = UITextField(frame: CGRect(x: 20.0, y: 30.0, width: 100.0, height: 33.0))
        searchTextField.backgroundColor = .white
        searchTextField.borderStyle = .line
        searchTextField.delegate = self
        searchTextField.isHidden = true
        presentLoadingScreen()
        locationRepo.load()
        setupConstraints()
        style()
    }

    func style() {
        pageControl.clipsToBounds = true
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = UIColor(named: "Light Turqoise")
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
    }

    func setupConstraints() {
        view.addSubview(pageControl)

        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 2).isActive = true
        
        showListButton.translatesAutoresizingMaskIntoConstraints = false
        showListButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -42 / 2).isActive = true
        showListButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 42 / 2 - showListButton.bounds.height / 2 ).isActive = true

    }

    func setupBindings() {
        setupLocalRepoBind()

        locationManager = CLLocationManager.publishLocation()
            .sink(receiveValue: { coordinates in
                coordinates.getCity { cityName, countryName, _ in
                    if let cityName = cityName, let countryName = countryName {
                        self.currentLocationName = "\(cityName), \(countryName)"
                        self.locationRepo.addNewCity(name: "\(cityName), \(countryName)")
                        print("weather change")
                    }
                }
            })
    }

    func setupLocalRepoBind() {
        locationRepo.observeChanges()
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { cityNames in
                self.updatePages(cityNames: cityNames)
                print("repo change")
            }
            .store(in: &cancellables)
    }

    func updatePages(cityNames: [String]) {
        DispatchQueue.main.async { [self] in
            print(addedCityNames)
            for name in cityNames.filter({ !addedCityNames.contains($0) }) {
                name.getCoordinate(completion: { [self] coordinates, _ in
                    if let coordinates = coordinates {
                        print("updatin new \(name)")
                        print("updatin currentlox \(currentLocationName)")
                        if name == currentLocationName {
                            print("bingo")
                        }
                        pages.append(specificLocationVC(coordinates: coordinates))
                        addedCityNames.append(name)
                    }
                    refreshPages()
                    self.cityNamesPublisher.send(self.addedCityNames)
                    setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
                    hideLoadingScreen()
                    cancellables.forEach { $0.cancel() }
                })}
        }
    }

    func refreshPages() {
        DispatchQueue.main.async {
            self.dataSource = nil
            self.dataSource = self
            self.pageControl.numberOfPages = self.pages.count
        }
    }
}

// MARK: - DataSource
extension ViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return pages.first
        }
    }

}

// MARK: - Delegates
extension ViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }

        pageControl.currentPage = currentIndex
        animateControlsIfNeeded()
    }

    private func animateControlsIfNeeded() {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

// MARK: - Gesture
extension ViewController {

    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        animateControlsIfNeeded()
    }

}

// MARK: - Extensions
extension UIPageViewController {

    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }

        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }

    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }

        setViewControllers([prevPage], direction: .forward, animated: animated, completion: completion)
    }

    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
    }
}

extension ViewController: UITextFieldDelegate {
    @objc func addPressed() {
        searchTextField.endEditing(true)
        searchTextField.isHidden = false
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)

        DispatchQueue.main.async() {
            self.dataSource = nil
            self.dataSource = self
            self.pageControl.numberOfPages = self.pages.count
        }

        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "<City name>, <Country name>"
            return false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.isHidden = true
        print("End of edit")
        if let city = searchTextField.text {
            print ("adding \(city)")
            city.getCoordinate { coordinates, error in
                if let error = error {
                    print("error adding: \(error)")
                }
                if coordinates != nil  {
                    self.setupLocalRepoBind()
                    self.locationRepo.addNewCity(name: city)
                }
            }
        }
        searchTextField.text = ""
    }

}
