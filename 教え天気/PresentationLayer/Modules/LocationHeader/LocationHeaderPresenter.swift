//
//  LocationHeaderPresenter.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//  
//

import Foundation

class LocationHeaderPresenter: ViewToPresenterLocationHeaderProtocol {
    // MARK: Properties
    var view: PresenterToViewLocationHeaderProtocol?
    var interactor: PresenterToInteractorLocationHeaderProtocol?
    var router: PresenterToRouterLocationHeaderProtocol?

    func updateView() {
        interactor?.fetchAddress()
    }
}

extension LocationHeaderPresenter: InteractorToPresenterLocationHeaderProtocol {
    func addressFetched(address: String) {
        view?.showAddress(withAddress: address)
    }

    func addressFetchedFailed(message address: String) {
        // popup for error
    }
}
