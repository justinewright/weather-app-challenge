//
//  NavigationBuilder.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/21.
//

import UIKit

typealias NavigationFactory = (UIViewController) -> (UINavigationController)

class NavigationBuilder {
    static func build(rootView: UIViewController) -> UINavigationController {
        let textStyleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        let navigationController = UINavigationController(rootViewController: rootView)
        let navBar = navigationController.navigationBar
        navBar.barTintColor = .clear
        navBar.backgroundColor = .clear

        navBar.isTranslucent = false
        navBar.prefersLargeTitles = false
        navBar.titleTextAttributes = textStyleAttributes

        rootView.view.frame = CGRect(x: width * 0.1 / 2, y: height * 0.1 / 2, width: width * 0.8, height: height * 0.8)
        rootView.view.layer.masksToBounds = true
        rootView.view.layer.cornerRadius = 20
        
        return navigationController
    }
}
