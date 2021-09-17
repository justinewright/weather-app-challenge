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
        
        let interactor = LocationsWeatherOverviewInteractor()
//        let repo = AddressRepository()

//        DispatchQueue.main.async {
//            repo.addresses.forEach { address in
//                address.coordinate{ coordinates, _ in
//                    if let coordinates = coordinates {
//                        interactor.addAddress(coordinates: coordinates)
//                    }
//                }
//            }
//        }
        viewController.presenter?.interactor = interactor
        viewController.presenter?.interactor?.presenter = presenter

        return viewController
    }
    
}
