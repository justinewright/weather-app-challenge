//
//  LocationsWeatherOverviewViewController.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//  
//

import UIKit
import CoreLocation

class LocationsWeatherOverviewViewController: UIViewController {

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        presenter?.fetchPages()

    }
    // MARK: - Initialization

    init() {
        locationsWeatherOverviewPageController = LocationsWeatherOverviewPageController()
        super.init(nibName: nil, bundle: nil)
        presenter?.fetchPages()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties
    
    var presenter: ViewToPresenterLocationsWeatherOverviewProtocol?
    private var locationsWeatherOverviewPageController: LocationsWeatherOverviewPageController!
    private var onePageViewController: UIViewController!

    private func setupView() {
        onePageViewController = UIViewController()

        self.addChild(onePageViewController)
        view.addSubview(onePageViewController.view)
        onePageViewController.didMove(toParent: self)
        onePageViewController.view.isHidden = true

        locationsWeatherOverviewPageController = LocationsWeatherOverviewPageController()
//        presenter?.fetchPages()
        self.addChild(locationsWeatherOverviewPageController)
        self.view.addSubview(locationsWeatherOverviewPageController.view)
        self.locationsWeatherOverviewPageController.didMove(toParent: self)
        locationsWeatherOverviewPageController.view.isHidden = true

        setupConstraints()
    }

    private func setupConstraints() {
        let locationsWeatherOverviewView = locationsWeatherOverviewPageController.view!
        locationsWeatherOverviewView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            locationsWeatherOverviewView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            locationsWeatherOverviewView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            locationsWeatherOverviewView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            locationsWeatherOverviewView.topAnchor.constraint(equalTo: self.view.topAnchor)
        ])
    }
    
}

extension LocationsWeatherOverviewViewController: PresenterToViewLocationsWeatherOverviewProtocol{
    func showPages(usingWeatherEntitiesRepos repos: [WeatherEntitiesRepository]) {
        DispatchQueue.main.async { [self] in
            if repos.isEmpty { return }
            let pages = repos.map {WeatherOverviewRouter.createModule(repo: $0)}
            if pages.count == 1 {
                locationsWeatherOverviewPageController.view.isHidden = true
                pages.first!.view.frame = CGRect(x: width * 0.1 / 2, y: 0, width: width * 0.9, height: height * 0.8)
                pages.first!.view.layer.masksToBounds = true
                pages.first!.view.layer.cornerRadius = 20
                onePageViewController.addChild(pages.first!)
                onePageViewController.view.addSubview((pages.first?.view)!)
                pages.first?.didMove(toParent: onePageViewController)

                onePageViewController.view.isHidden = false
            } else {
                onePageViewController.children.forEach { child in
                    child.removeFromParent()
                }
                onePageViewController.view.isHidden = true
                locationsWeatherOverviewPageController.refresh(pages: pages)
                locationsWeatherOverviewPageController.view.isHidden = false
            }
        }

    }
    // TODO: Implement View Output Methods
}
