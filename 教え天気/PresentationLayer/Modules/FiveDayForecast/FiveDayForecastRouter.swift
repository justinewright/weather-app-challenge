//
//  FiveDayForecastRouter.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//  
//

import Foundation
import UIKit

class FiveDayForecastRouter: PresenterToRouterFiveDayForecastProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = FiveDayForecastViewController()
        
        let presenter: ViewToPresenterFiveDayForecastProtocol & InteractorToPresenterFiveDayForecastProtocol = FiveDayForecastPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = FiveDayForecastRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = FiveDayForecastInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        viewController.presenter?.interactor?.forecastWeatherPublisher = WeatherEntitiesRepository(lat: locationCoordinates[0].latitude, lon: locationCoordinates[0].longitude)

        return viewController
    }

    static func createModule(weatherEntitiesRepository: WeatherEntitiesRepository) -> UIViewController {

        let viewController = FiveDayForecastViewController()

        let presenter: ViewToPresenterFiveDayForecastProtocol & InteractorToPresenterFiveDayForecastProtocol = FiveDayForecastPresenter()

        viewController.presenter = presenter
        viewController.presenter?.router = FiveDayForecastRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = FiveDayForecastInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        viewController.presenter?.interactor?.forecastWeatherPublisher = weatherEntitiesRepository

        return viewController
    }
    
}
