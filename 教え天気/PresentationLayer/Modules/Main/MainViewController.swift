//
//  MainViewController.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/16.
//  
//

import UIKit

let width = UIScreen.main.bounds.width
let height = UIScreen.main.bounds.height
typealias MainTabs = (
    weather: UIViewController,
    cloudMap: UIViewController,
    locationsList: UIViewController
)

class MainViewController: UITabBarController {
    
    init(tabs: MainTabs) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [tabs.weather, tabs.cloudMap, tabs.locationsList]
        applyStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
    }

    // MARK: - Properties
    var presenter: ViewToPresenterMainProtocol?

    private func applyStyle() {
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .black
        self.tabBar.unselectedItemTintColor = .none
        self.tabBar.tintColor = .gray
        let textStyleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        self.tabBarItem.setTitleTextAttributes(textStyleAttributes, for: .selected)
    }
}

extension MainViewController: PresenterToViewMainProtocol {
    
    // TODO: Implement View Output Methods
}
