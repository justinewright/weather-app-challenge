//
//  LocationRepo.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/06.
//

import Foundation
import CoreLocation
import Combine

class LocationRepo {

    static let shared = LocationRepo()
    private let userDefaults = UserDefaults.standard
    private var cityNames: [String] = []
    private let key = "locations"
    private let cities = PassthroughSubject<[String], Never>()

    private init() {}

    func save() {
        userDefaults.set(cityNames, forKey: key)
        cities.send(cityNames)
    }

    func load() {
        cityNames = (userDefaults.object(forKey: key) as? [String]) ?? []
        cities.send(cityNames)
    }

    func addNewCity(name: String) {
        cityNames.append(name)
        save()
    }

    func observeChanges() -> AnyPublisher<[String], Never> {
        cities.eraseToAnyPublisher()
    }
}
