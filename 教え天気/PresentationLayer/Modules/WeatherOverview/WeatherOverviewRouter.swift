//
//  WeatherOverviewRouter.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//  
//

import Foundation
import UIKit

class WeatherOverviewRouter: PresenterToRouterWeatherOverviewProtocol {

    // MARK: Static methods

    static func createModule(repo: WeatherEntitiesRepository) -> UIViewController {

        let presenter: ViewToPresenterWeatherOverviewProtocol & InteractorToPresenterWeatherOverviewProtocol = WeatherOverviewPresenter()
        let viewController = WeatherOverviewViewController(usingSubmodules: createSubmodules(withRepo: repo))
        viewController.title = "Weather"
        viewController.presenter = presenter
        viewController.presenter?.router = WeatherOverviewRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = WeatherOverviewInteractor()
        viewController.presenter?.interactor?.presenter = presenter

        return viewController
    }
    
}

private extension WeatherOverviewRouter {
    static func createSubmodules(withRepo repo: WeatherEntitiesRepository) -> WeatherOverviewSubmodules {
        return (
            locationHeader: LocationHeaderRouter.createModule(repo: repo),
            currentWeather: CurrentWeatherRouter.createModule(repo: repo),
            hourlyWeather: HourlyForecastRouter.createModule(repo: repo),
            fiveDayForecast: FiveDayForecastRouter.createModule(repo: repo),
            detailsView: WeatherDetailsRouter.createModule()
        )
    }
}
