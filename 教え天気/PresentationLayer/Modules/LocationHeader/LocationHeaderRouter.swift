//
//  LocationHeaderRouter.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//  
//

import Foundation
import UIKit

class LocationHeaderRouter: PresenterToRouterLocationHeaderProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = LocationHeaderViewController()

        let presenter: ViewToPresenterLocationHeaderProtocol & InteractorToPresenterLocationHeaderProtocol =
            LocationHeaderPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = LocationHeaderRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = LocationHeaderInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        viewController.presenter?.interactor?.addressPublisher = WeatherEntitiesRepository(lat: locationCoordinates[0].latitude, lon: locationCoordinates[0].longitude)
        
        return viewController
    }
    static func createModule(weatherEntitiesRepository: WeatherEntitiesRepository) -> UIViewController {

        let viewController = LocationHeaderViewController()

        let presenter: ViewToPresenterLocationHeaderProtocol & InteractorToPresenterLocationHeaderProtocol =
            LocationHeaderPresenter()

        viewController.presenter = presenter
        viewController.presenter?.router = LocationHeaderRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = LocationHeaderInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        viewController.presenter?.interactor?.addressPublisher = weatherEntitiesRepository

        return viewController
    }
    
}
