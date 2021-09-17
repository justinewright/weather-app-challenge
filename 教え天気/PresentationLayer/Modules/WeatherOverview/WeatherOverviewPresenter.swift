//
//  WeatherOverviewPresenter.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//  
//

import UIKit

enum WeatherOverViewSubModules: Int, CaseIterable {
    case locationHeader
    case currentWeather
    case fiveDayForecast

    func content(repo: WeatherEntitiesRepository) -> UIViewController {
        switch self {
        case .locationHeader:
            return LocationHeaderRouter.createModule(weatherEntitiesRepository: repo)
        case .currentWeather:
            return CurrentWeatherRouter.createModule(weatherEntitiesRepository: repo)
        case .fiveDayForecast:
            return FiveDayForecastRouter.createModule(weatherEntitiesRepository: repo)
        }
    }
}

class WeatherOverviewPresenter: ViewToPresenterWeatherOverviewProtocol {
    func fetch() {
        interactor?.fetch()
    }

    // MARK: Properties
    var view: PresenterToViewWeatherOverviewProtocol?
    var interactor: PresenterToInteractorWeatherOverviewProtocol?
    var router: PresenterToRouterWeatherOverviewProtocol?

    var subModules: [UIViewController]?
}

extension WeatherOverviewPresenter: InteractorToPresenterWeatherOverviewProtocol {

}
