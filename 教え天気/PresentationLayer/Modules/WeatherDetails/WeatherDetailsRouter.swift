//
//  WeatherDetailsRouter.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/30.
//  
//

import Foundation
import UIKit

class WeatherDetailsRouter: PresenterToRouterWeatherDetailsProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = WeatherDetailsViewController()
        
        let presenter: ViewToPresenterWeatherDetailsProtocol & InteractorToPresenterWeatherDetailsProtocol = WeatherDetailsPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = WeatherDetailsRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = WeatherDetailsInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
