//
//  MainRouter.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/16.
//  
//

import Foundation
import UIKit

class MainRouter: PresenterToRouterMainProtocol {
    func refresh() {
        
    }


    // MARK: Static methods
    static func createModule() -> UITabBarController {
        
        let viewController = MainViewController()
        
        let presenter: ViewToPresenterMainProtocol & InteractorToPresenterMainProtocol = MainPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = MainRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = MainInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
