//
//  HourlyForecastRouter.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/29.
//  
//

import Foundation
import UIKit

class HourlyForecastRouter: PresenterToRouterHourlyForecastProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = HourlyForecastViewController()
        
        let presenter: ViewToPresenterHourlyForecastProtocol & InteractorToPresenterHourlyForecastProtocol = HourlyForecastPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = HourlyForecastRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = HourlyForecastInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
