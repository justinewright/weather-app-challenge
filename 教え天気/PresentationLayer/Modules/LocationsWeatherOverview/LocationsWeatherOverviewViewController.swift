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
        super.init(nibName: nil, bundle: nil)
        presenter?.fetchPages()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties
    
    var presenter: ViewToPresenterLocationsWeatherOverviewProtocol?
    private lazy var locationsWeatherOverviewPageController = LocationsWeatherOverviewPageController()

    private func setupView() {
        self.addChild(locationsWeatherOverviewPageController)
        self.locationsWeatherOverviewPageController.didMove(toParent: self)
        self.view.addSubview(locationsWeatherOverviewPageController.view)
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
        if repos.isEmpty { return }
        let pages = repos.map {WeatherOverviewRouter.createModule(repo: $0)}
        locationsWeatherOverviewPageController.refresh(pages: pages)
    }
    // TODO: Implement View Output Methods
}
