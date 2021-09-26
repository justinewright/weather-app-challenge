//
//  AddressRepository.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//

import Foundation
import CoreLocation

class AddressRepository {

    var addresses: [String]  {
        get {
            return UserDefaults.standard.addresses
        }
    }

    static let shared = AddressRepository()
    var isDirty = true

    private init() {
    }

    func add(newAddress name: String) {
        if addressExists(name: name, cityNames: addresses) {
            return
        }
        UserDefaults.standard.addresses.append(name)
        isDirty = true
        saveAddressesToUserStorage()
    }

    func add(currentAddress name: String) {
        if addressExists(name: name, cityNames: addresses) {
            UserDefaults.standard.addresses.removeAll { $0 == name }
        }
        UserDefaults.standard.addresses.insert(name, at: 0)
        isDirty = true
        saveAddressesToUserStorage()
    }

    private func saveAddressesToUserStorage() {
        UserDefaults.standard.addresses = addresses
    }

    private func addressExists(name: String, cityNames: [String]) -> Bool {
        return cityNames.contains(name)
    }

}
