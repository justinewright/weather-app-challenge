//
//  LocationsWeatherOverviewPresenter.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//  
//

import UIKit
import CoreLocation

class LocationsWeatherOverviewPresenter: ViewToPresenterLocationsWeatherOverviewProtocol {
    private var pages: [UIViewController] = []

    func fetchPages() {
        interactor?.fetchCoordinates()
    }

    // MARK: Properties
    var view: PresenterToViewLocationsWeatherOverviewProtocol?
    var interactor: PresenterToInteractorLocationsWeatherOverviewProtocol?
    var router: PresenterToRouterLocationsWeatherOverviewProtocol?

    var makeLocationsWeatherOverviewPageViewController: LocationsWeatherOverviewPageController {
        return LocationsWeatherOverviewPageController()
    }

    var emptyView: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .black
        return vc
    }()

    func specificLocationVC(lat: Double, lon: Double) -> UIViewController {
        let vc = WeatherOverviewRouter.createModule(lat: lat, lon: lon)
        return  vc
    }

}

extension LocationsWeatherOverviewPresenter: InteractorToPresenterLocationsWeatherOverviewProtocol {

    func updateWeatherOverviewPage(coordinates: CLLocationCoordinate2D) {
        DispatchQueue.main.async {
            self.pages.append(WeatherOverviewRouter.createModule(lat: coordinates.latitude, lon: coordinates.longitude))
            self.view?.refresh(pages: self.pages)
        }
    }

    func updateWeatherOverviewPages(coordinates: [CLLocationCoordinate2D]) {
        var pages: [UIViewController] = []
        coordinates.forEach { coordinate in
            pages.append(WeatherOverviewRouter.createModule(lat: coordinate.latitude, lon: coordinate.longitude))
        }
        view?.refresh(pages: pages)
    }
}
    
