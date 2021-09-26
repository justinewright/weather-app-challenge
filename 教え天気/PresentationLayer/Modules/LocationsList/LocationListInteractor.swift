//
//  LocationListInteractor.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/16.
//  
//

import Foundation

class LocationListInteractor: PresenterToInteractorLocationListProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterLocationListProtocol?
    private var dbAddressInteractor: LocationListToDatabase = Database.shared

    init() {

    }

    func addAddress(_ address: String) {
        DispatchQueue.main.async { [self] in
            dbAddressInteractor.addAddress(address)
            presenter?.fetchedAddresses(locationAddresses:  dbAddressInteractor.fetchAddresses())
        }
    }

    func fetchAddresses() {
        presenter?.fetchedAddresses(locationAddresses:  dbAddressInteractor.fetchAddresses())
    }

}
