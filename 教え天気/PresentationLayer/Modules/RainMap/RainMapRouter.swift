//
//  RainMapRouter.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/26.
//  
//

import Foundation
import UIKit

class RainMapRouter: PresenterToRouterRainMapProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = RainMapViewController()
        
        let presenter: ViewToPresenterRainMapProtocol & InteractorToPresenterRainMapProtocol = RainMapPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = RainMapRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = RainMapInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
