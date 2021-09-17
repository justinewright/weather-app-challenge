//
//  MainViewController.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/16.
//  
//

import UIKit
//TODO: - change into viper
//TODO: - dependency injection of repos
class MainViewController: UITabBarController {
    internal lazy var viewControllerss: [UINavigationController] = []
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    private func buildTabBarModule() {
        for tabItem in MainTabItem.allCases {
            let newVC = self.createTabBarItem(for: tabItem)
            newVC.view.frame = CGRect(x: width * 0.1 / 2, y: height * 0.1 / 2, width: width * 0.8, height: height * 0.8)
            newVC.view.layer.masksToBounds = true
            newVC.view.layer.cornerRadius = 20
            self.viewControllerss.append(self.createTabBarItem(for: tabItem))
        }
        self.setViewControllers(self.viewControllerss, animated: false)
        tabBar.barTintColor = .clear
        self.tabBar.isTranslucent = false
    }

    private func applyStyle() {
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .black
        self.tabBar.unselectedItemTintColor = .none
        self.tabBar.tintColor = .gray

    }

    private func createTabBarItem( for tabItem: MainTabItem) -> UINavigationController {
        let content = tabItem.content
        let viewController = content.viewController
        viewController.navigationBar.barTintColor = .black
        viewController.navigationBar.isTranslucent = false
        let tabBarItem = UITabBarItem(
            title: "",
            image: content.enabledIcon,
            selectedImage: content.activeIcon)
        tabBarItem.selectedImage?.withTintColor(.clear)
        viewController.tabBarItem = tabBarItem
        return viewController
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        buildTabBarModule()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterMainProtocol?
    
}

extension MainViewController: PresenterToViewMainProtocol{
    // TODO: Implement View Output Methods
}

var refreshMainView = false
