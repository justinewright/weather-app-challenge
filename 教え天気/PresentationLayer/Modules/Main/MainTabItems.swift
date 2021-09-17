//
//  MainTabItems.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/16.
//
import UIKit

enum MainTabItem: String, CaseIterable {
    case fiveDayForecast = "Five Day Forecast"
    case locationList = "Locations"

    struct Content {
        let title: String
        let viewController: UINavigationController
        let activeIcon: UIImage
        let enabledIcon: UIImage
    }

    var content: Content {
        switch self {
        case .fiveDayForecast:
            return Content(title: self.rawValue.capitalized,
                           viewController: UINavigationController(rootViewController: LocationsWeatherOverviewRouter.createModule()),
                           activeIcon: UIImage(systemName: "cloud.heavyrain")!.withTintColor(.white),
                           enabledIcon: UIImage(systemName: "cloud.heavyrain")!.withTintColor(.gray))
        case .locationList:
            return Content(title: self.rawValue.capitalized,
                           viewController: UINavigationController(rootViewController: LocationListRouter.createModule()),
                           activeIcon: UIImage(systemName: "list.dash")!.withTintColor(.white),
                           enabledIcon: UIImage(systemName: "list.dash")!.withTintColor(.gray))

        }
    }
}
