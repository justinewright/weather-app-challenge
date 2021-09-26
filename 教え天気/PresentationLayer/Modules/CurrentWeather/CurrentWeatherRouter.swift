//
//  HourlyWeatherRouter.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//  
//

import Foundation
import UIKit

//TODO: - make default weatherEntitiesRepo
class CurrentWeatherRouter: PresenterToRouterCurrentWeatherProtocol {
    
    // MARK: Static methods
    static func createModule(repo: WeatherEntitiesRepositoryCurrentWeatherPublisher) -> UIViewController {

        let viewController = CurrentWeatherViewController()

        let presenter: ViewToPresenterCurrentWeatherProtocol & InteractorToPresenterCurrentWeatherProtocol = CurrentWeatherPresenter()

        viewController.presenter = presenter
        viewController.presenter?.router = CurrentWeatherRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = CurrentWeatherInteractor(weatherEntitiesRepository: repo)
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
