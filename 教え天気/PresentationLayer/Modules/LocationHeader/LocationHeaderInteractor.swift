//
//  LocationHeaderInteractor.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//  
//

import Foundation
import Combine

class LocationHeaderInteractor: PresenterToInteractorLocationHeaderProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterLocationHeaderProtocol?
    private var repo: WeatherEntitiesRepositoryAddressProtocol

    init(repo: WeatherEntitiesRepositoryAddressProtocol) {
        self.repo = repo
    }

    func fetchAddress() {
        presenter?.addressFetched(address: repo.fetch())
    }
}
