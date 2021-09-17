//
//  AddressRepository.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//

import Foundation
import CoreLocation
import Combine

class AddressRepository {

    @Published private (set) var addressStrings: [String] = []
    private var cancellables: Set<AnyCancellable> = []

    init() {
        setBindings()
    }

    private func saveAddressesToUserStorage() {
        UserDefaults.standard.addresses = addressStrings
    }

    func addNewAddress(name: String) {
        if addressExists(name: name, cityNames: addressStrings) {
            return
        }
        addressStrings.append(name)
        saveAddressesToUserStorage()
    }

    func addressExists(name: String, cityNames: [String]) -> Bool {
        return cityNames.contains(name)
    }

    func loadAddresses() {
        addressStrings = UserDefaults.standard.addresses
    }
    
    var addresses: [String] {
        return UserDefaults.standard.addresses
    }

    func setBindings() {
        UserDefaults.standard
            .publisher(for: \.addresses)
            .handleEvents(receiveOutput: { self.addressStrings = $0 })
            .sink { _ in}
            .store(in: &cancellables)
    }

}

extension AddressRepository: AddressPublisher {
    func addressPub() -> AnyPublisher<[String], Never> {
        $addressStrings
            .debounce(for: 0, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
