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
    var addressPublisher: WeatherEntitiesRepositoryAddressPublisher? {
        didSet(addressPub) {
            bindAddressPublisher()
        }
    }

    private var cancellables: Set<AnyCancellable> = []

    init() {}

    private func bindAddressPublisher() {
        addressPublisher?.addressPub()
            .sink(receiveValue: { address in
                self.presenter?.updateLocation(withAddress: address)
            }).store(in: &cancellables)

    }
}
