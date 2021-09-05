//
//  LocationViewModel.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/31.
//

import Foundation
import CoreLocation
import Combine

class LocationManager {
    @Published var coordinates: CLLocationCoordinate2D!

    private var cancellables: Set<AnyCancellable> = []

    init() {
        CLLocationManager.publishLocation()
            .map{$0}
            .assign(to: \.coordinates, on: self)
            .store(in: &cancellables)
    }
}
