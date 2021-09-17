//
//  HourlyWeatherRouter.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//  
//

import Foundation
import UIKit

class CurrentWeatherRouter: PresenterToRouterCurrentWeatherProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = CurrentWeatherViewController()
        
        let presenter: ViewToPresenterCurrentWeatherProtocol & InteractorToPresenterCurrentWeatherProtocol = CurrentWeatherPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = CurrentWeatherRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = CurrentWeatherInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        viewController.presenter?.interactor?.currentWeatherPublisher = WeatherEntitiesRepository(lat: locationCoordinates[0].latitude, lon: locationCoordinates[0].longitude)
        
        return viewController
    }

    static func createModule(weatherEntitiesRepository: WeatherEntitiesRepository) -> UIViewController {

        let viewController = CurrentWeatherViewController()

        let presenter: ViewToPresenterCurrentWeatherProtocol & InteractorToPresenterCurrentWeatherProtocol = CurrentWeatherPresenter()

        viewController.presenter = presenter
        viewController.presenter?.router = CurrentWeatherRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = CurrentWeatherInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        viewController.presenter?.interactor?.currentWeatherPublisher = weatherEntitiesRepository
        
        return viewController
    }
    
}
