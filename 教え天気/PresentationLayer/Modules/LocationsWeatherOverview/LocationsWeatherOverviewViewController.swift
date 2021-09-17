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
        self.presenter?.fetchPages()
        print("updating view")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties
    var presenter: ViewToPresenterLocationsWeatherOverviewProtocol?
    var locationsWeatherOverviewPageController: LocationsWeatherOverviewPageController!
    var isLoading: Bool = false {
        willSet(value) {
            if value {
                self.presenter?.fetchPages()
            }
        }
    }

    private func setupView() {
        self.locationsWeatherOverviewPageController = presenter?.makeLocationsWeatherOverviewPageViewController
        self.addChild(locationsWeatherOverviewPageController)
        self.view.addSubview(locationsWeatherOverviewPageController.view)
        self.locationsWeatherOverviewPageController.didMove(toParent: self)
//        DispatchQueue.main.async {
//            self.presenter?.updatePages()
//        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isLoading = true
        }
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
    func refresh(pages: [UIViewController]) {
        locationsWeatherOverviewPageController.refresh(pages: pages)
    }
    // TODO: Implement View Output Methods
}
