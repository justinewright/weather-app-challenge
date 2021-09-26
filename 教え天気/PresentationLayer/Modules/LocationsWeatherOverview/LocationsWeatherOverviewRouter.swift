//
//  LocationsWeatherOverviewRouter.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//  
//

import Foundation
import UIKit

class LocationsWeatherOverviewRouter: PresenterToRouterLocationsWeatherOverviewProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = LocationsWeatherOverviewViewController()
        
        let presenter: ViewToPresenterLocationsWeatherOverviewProtocol & InteractorToPresenterLocationsWeatherOverviewProtocol = LocationsWeatherOverviewPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = LocationsWeatherOverviewRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = LocationsWeatherOverviewInteractor()
        viewController.presenter?.interactor?.presenter = presenter

        return viewController
    }
    
}
