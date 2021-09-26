//
//  LocationListPresenter.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/16.
//  
//

import Foundation

class LocationListPresenter: ViewToPresenterLocationListProtocol {

    // MARK: Properties
    var view: PresenterToViewLocationListProtocol?
    var interactor: PresenterToInteractorLocationListProtocol?
    var router: PresenterToRouterLocationListProtocol?

    func addAddress(_ address: String) {}

    func updateView() {
        interactor?.fetchAddresses()
    }

    @objc func addLocationButtonPressed() {
        router?.presentLocationSearcher(rootView: view!, completion: { address in
            DispatchQueue.main.async {
            
            self.interactor?.addAddress(address)
            }
        })
    }

}

extension LocationListPresenter: InteractorToPresenterLocationListProtocol {
    func fetchedAddresses(locationAddresses: [String]) {
        view?.showLocations(withAddresses: locationAddresses)
    }

    func fetchedAddressesFailed(message: String) {
        // something
    }

}
