//
//  LocationsWeatherOverviewPageController.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//

import UIKit
import CoreLocation

class LocationsWeatherOverviewPageController: UIPageViewController {
    
    private var pages = [UIViewController]()

    lazy var emptyView: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        return vc
    }()

    private let pageControl = UIPageControl()
    private let initialPage = UIPageControl.sharedCurrentPage
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewController.OptionsKey.interPageSpacing: 5])
        pages = [emptyView]
        view.backgroundColor = .black
    }

    required init?(coder: NSCoder) {
        super.init(transitionStyle:.scroll, navigationOrientation: .horizontal, options: nil)
        pages = [emptyView]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func refresh(pages: [UIViewController]) {
        DispatchQueue.main.async {
            if pages.isEmpty {
                return
            }
            self.view.isUserInteractionEnabled = pages.count > 1
            self.pages = pages
            self.setViewControllers([self.pages[UIPageControl.sharedCurrentPage]], direction: .forward, animated: true, completion: nil)
            self.dataSource = nil
            self.dataSource = self
            self.pageControl.numberOfPages = self.pages.count
        }
    }
}

private extension LocationsWeatherOverviewPageController {
    private func setupView() {
        dataSource = self
        delegate = self

        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)

        setupConstraints()
        style()
    }

    private func style() {
        pageControl.clipsToBounds = true
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = UIColor(named: "Light Turqoise")
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
    }

    private func setupConstraints() {
        view.addSubview(pageControl)

        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 2).isActive = true
    }

}
// MARK: - DataSource
extension LocationsWeatherOverviewPageController: UIPageViewControllerDataSource {

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
extension LocationsWeatherOverviewPageController: UIPageViewControllerDelegate {

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
extension LocationsWeatherOverviewPageController {

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
