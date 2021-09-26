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
    
    static func createModule(repo: WeatherEntitiesRepositoryAddressProtocol) -> UIViewController {

        let viewController = LocationHeaderViewController()

        let presenter: ViewToPresenterLocationHeaderProtocol & InteractorToPresenterLocationHeaderProtocol =
            LocationHeaderPresenter()

        viewController.presenter = presenter
        viewController.presenter?.router = LocationHeaderRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = LocationHeaderInteractor(repo: repo)
        viewController.presenter?.interactor?.presenter = presenter

        return viewController
    }
    
}
