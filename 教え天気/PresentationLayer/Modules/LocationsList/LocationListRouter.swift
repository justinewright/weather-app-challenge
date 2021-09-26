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
    func presentLocationSearcher(rootView: PresenterToViewLocationListProtocol, completion: @escaping (String) -> Void) {
        guard let rootView = rootView as? UIViewController else {
            return
        }
        let searchBar = LocationSearchBarViewController()
        searchBar.title = "Add Location"

        let navVC = UINavigationController(rootViewController: searchBar)
        navVC.modalPresentationStyle = .overFullScreen
        navVC.navigationBar.backgroundColor = .black
        navVC.navigationBar.tintColor = .white

        rootView.present(navVC, animated: true, completion: nil)

        searchBar.callback = { (address, _) -> Void in
            navVC.dismiss(animated: true, completion: nil)
            completion(address)
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
