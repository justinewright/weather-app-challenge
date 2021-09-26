//
//  LocationsWeatherOverviewContract.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//  
//

import UIKit
import CoreLocation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewLocationsWeatherOverviewProtocol {
    func showPages(usingWeatherEntitiesRepos repos: [WeatherEntitiesRepository])
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterLocationsWeatherOverviewProtocol {
    
    var view: PresenterToViewLocationsWeatherOverviewProtocol? { get set }
    var interactor: PresenterToInteractorLocationsWeatherOverviewProtocol? { get set }
    var router: PresenterToRouterLocationsWeatherOverviewProtocol? { get set }

    func fetchPages()
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorLocationsWeatherOverviewProtocol {
    var presenter: InteractorToPresenterLocationsWeatherOverviewProtocol? { get set }

    func fetchPages()
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterLocationsWeatherOverviewProtocol {
    func fetchedPages(repos: [WeatherEntitiesRepository])
    func fetchedPagesFailed(message: String)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterLocationsWeatherOverviewProtocol {

}
