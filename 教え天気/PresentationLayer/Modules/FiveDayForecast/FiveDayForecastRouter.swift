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

    static func createModule(repo: WeatherEntitiesRepositoryDailyForecastWeatherPublisher) -> UIViewController {

        let viewController = FiveDayForecastViewController()

        let presenter: ViewToPresenterFiveDayForecastProtocol & InteractorToPresenterFiveDayForecastProtocol = FiveDayForecastPresenter()

        viewController.presenter = presenter
        viewController.presenter?.router = FiveDayForecastRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = FiveDayForecastInteractor(repo: repo)
        viewController.presenter?.interactor?.presenter = presenter

        return viewController
    }
    
}
