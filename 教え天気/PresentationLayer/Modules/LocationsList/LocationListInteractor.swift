//
//  LocationListInteractor.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/16.
//  
//

import Foundation

class LocationListInteractor: PresenterToInteractorLocationListProtocol {
    func addAddress(_ address: String) {
        addressRepository.addNewAddress(name: address)
        presenter?.update(locationAddresses: addressRepository.addresses)
    }

    func fetchAddresses() {
        presenter?.update(locationAddresses: addressRepository.addresses)
    }

    // MARK: Properties
    var presenter: InteractorToPresenterLocationListProtocol?
    private let addressRepository = AddressRepository()
}
