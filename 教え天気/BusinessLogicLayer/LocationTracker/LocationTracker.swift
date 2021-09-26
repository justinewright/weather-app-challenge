//
//  LocationTracker.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/23.
//

import Foundation
import Combine
import CoreLocation

class LocationTracker {
    private var locationManager: AnyCancellable?

    static let shared = LocationTracker()

    private init() {
        locationManager = CLLocationManager.publishLocation()
            .receive(on: RunLoop.main)
            .sink(receiveValue: { coordinates in
                coordinates.address(completion: { cityName, countryCode, _ in
                    if let cityName = cityName, let countryCode = countryCode {
                        Database.shared.addCurrentAddress("\(cityName), \(countryCode)")
                    }
                })
            })
    }

}
