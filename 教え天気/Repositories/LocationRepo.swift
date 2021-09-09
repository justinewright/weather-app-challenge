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
    private var cityNames: [String] = [] // subject
    private let key = "locations"
    private let cities = PassthroughSubject<[String], Never>() // publisher
    var isAllowedToSubmit = true
    private init() {}

    private func save() {
        userDefaults.set(cityNames, forKey: key)
        cities.send(cityNames)
        print(cityNames)
        print("repo save")
    }

    func load() {
        cityNames = userDefaults.stringArray(forKey: key) ?? [String]()
        cities.send(cityNames)
        print("repo load")
    }

    func addNewCity(name: String) {
        if cityExists(name: name, cityNames: cityNames) {
            return
        }
        cityNames.append(name)
        save()
    }

    func cityExists(name: String, cityNames: [String]) -> Bool {
        return cityNames.contains(name)
    }

    func observeChanges() -> AnyPublisher<[String], Never> {
        cities.eraseToAnyPublisher()
    }
}
