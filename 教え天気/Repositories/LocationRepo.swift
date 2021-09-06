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
    let userDefaults = UserDefaults.standard
    @Published var dictionary: [String: CLLocationCoordinate2D] = [:]
    let key = "locations"
    let cities = PassthroughSubject<[String: CLLocationCoordinate2D], Never>()

    func save() {
        cities.send(dictionary)
        userDefaults.set(dictionary, forKey: key)
    }

    func load() {
        dictionary = (userDefaults.object(forKey: key) as? [String: CLLocationCoordinate2D]) ?? [:]
    }

    func addNewCity(name: String, coordinates: CLLocationCoordinate2D){
        dictionary[name] = coordinates
        save()
    }

    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
}
