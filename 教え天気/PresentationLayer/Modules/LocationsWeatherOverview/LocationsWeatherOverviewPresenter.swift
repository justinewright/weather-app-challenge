//
//  LocationsWeatherOverviewPresenter.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//  
//

import CoreLocation

class LocationsWeatherOverviewPresenter: ViewToPresenterLocationsWeatherOverviewProtocol {

    // MARK: Properties
    var view: PresenterToViewLocationsWeatherOverviewProtocol?
    var interactor: PresenterToInteractorLocationsWeatherOverviewProtocol?
    var router: PresenterToRouterLocationsWeatherOverviewProtocol?

    func fetchPages() {
        interactor?.fetchPages()
    }
}

extension LocationsWeatherOverviewPresenter: InteractorToPresenterLocationsWeatherOverviewProtocol {
    func fetchedPages(repos: [WeatherEntitiesRepository]) {
        view?.showPages(usingWeatherEntitiesRepos: repos)
    }
    
    func fetchedPagesFailed(message: String) {
        // something
    }
}
    
