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

    typealias Submodules = (
        weather: UINavigationController,
        cloudMap: UINavigationController,
        locationsList: UINavigationController
    )

    // MARK: Static methods
    static func createModule() -> UITabBarController {
        
        let viewController = MainViewController(tabs: tabs(usingSubmodules: createSubmodules()))
        let presenter: ViewToPresenterMainProtocol & InteractorToPresenterMainProtocol = MainPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = MainRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = MainInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
}
class SecondViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "map"
        view.backgroundColor = .white
    }
}

extension MainRouter {

    static func createSubmodules() -> Submodules {
        return (
            weather: NavigationBuilder.build(rootView: LocationsWeatherOverviewRouter.createModule()),
            cloudMap: NavigationBuilder.build(rootView:SecondViewController()),
            locationsList: NavigationBuilder.build(rootView: LocationListRouter.createModule())
        )

    }
    static func tabs(usingSubmodules submodules: Submodules) -> MainTabs {
        let weatherTabBarItem =  createTabItem(title: "Weather", tabImage: UIImage(systemName: "cloud.heavyrain")!)
        let cloudMapTabBarItem =  createTabItem(title: "Rain", tabImage: UIImage(systemName: "drop.fill")!)
        let locationsListTabBarItem =  createTabItem(title: "Locations", tabImage: UIImage(systemName: "list.dash")!)

        submodules.weather.tabBarItem = weatherTabBarItem
        submodules.cloudMap.tabBarItem = cloudMapTabBarItem
        submodules.locationsList.tabBarItem = locationsListTabBarItem

        return (
            weather: submodules.weather,
            cloudMap: submodules.cloudMap,
            locationsList: submodules.locationsList
        )
    }

    private static func createTabItem(title: String, tabImage: UIImage) -> UITabBarItem {
        UITabBarItem(title: title,
                     image: tabImage.withTintColor(.gray, renderingMode: .alwaysOriginal),
                     selectedImage: tabImage.withTintColor(.white, renderingMode: .alwaysOriginal))
    }
}
