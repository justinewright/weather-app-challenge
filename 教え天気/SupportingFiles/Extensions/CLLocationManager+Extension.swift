//
//  CLLocationManager+Extension.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//

import Foundation
import CoreLocation
import Combine

extension CLLocationManager {
    public static func publishLocation() -> AnyPublisher<CLLocationCoordinate2D, Never> {
        Publishers.LocationPublisher().eraseToAnyPublisher()
    }
}
