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
    static func createModule() -> UIViewController {
        
        let viewController = WeatherOverviewViewController()
        
        let presenter: ViewToPresenterWeatherOverviewProtocol & InteractorToPresenterWeatherOverviewProtocol = WeatherOverviewPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = WeatherOverviewRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = WeatherOverviewInteractor()

        viewController.presenter?.interactor?.presenter = presenter

        let repo = WeatherEntitiesRepository(lat: locationCoordinates[0].latitude, lon: locationCoordinates[0].longitude)

        viewController.presenter?.interactor?.weatherEntityRepository = repo

        viewController.presenter?.subModules = []
        WeatherOverViewSubModules.allCases.forEach { submodule in
            viewController.presenter?.subModules!.append(submodule.content(repo: repo))
        }
        
        return viewController
    }

    static func createModule(lat: Double, lon: Double) -> UIViewController {

        let presenter: ViewToPresenterWeatherOverviewProtocol & InteractorToPresenterWeatherOverviewProtocol = WeatherOverviewPresenter()
        let viewController = WeatherOverviewViewController()

        viewController.presenter = presenter
        viewController.presenter?.router = WeatherOverviewRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = WeatherOverviewInteractor()
        viewController.presenter?.interactor?.presenter = presenter

        let repo = WeatherEntitiesRepository(lat: lat, lon: lon)
        viewController.presenter?.interactor?.weatherEntityRepository = repo
        viewController.presenter?.subModules = []
        WeatherOverViewSubModules.allCases.forEach { submodule in
            viewController.presenter?.subModules!.append(submodule.content(repo: repo))
        }
        
        viewController.view.layer.cornerRadius = 20
        viewController.view.clipsToBounds = true

        return viewController
    }
    
}
