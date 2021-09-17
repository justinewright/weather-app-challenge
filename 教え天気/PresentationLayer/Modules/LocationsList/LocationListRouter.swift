//
//  LocationListRouter.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/16.
//  
//

import Foundation
import UIKit

class LocationListRouter: PresenterToRouterLocationListProtocol {

    func locationSearcher(vc: LocationListViewController) {

        let searchBar = LocationSearchBarViewController()
        searchBar.title = "Add Location"

        let navVC = UINavigationController(rootViewController: searchBar)
        navVC.modalPresentationStyle = .overFullScreen
        navVC.navigationBar.backgroundColor = .black
        navVC.navigationBar.tintColor = .white

        vc.present(navVC, animated: true, completion: nil)

        searchBar.callback = { (address, _) -> Void in
            vc.presenter?.addAddress(address)
            refreshMainView = true
            navVC.dismiss(animated: true, completion: nil)
        }
    }

    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = LocationListViewController()
        
        let presenter: ViewToPresenterLocationListProtocol & InteractorToPresenterLocationListProtocol = LocationListPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = LocationListRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = LocationListInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
