//
//  LocationsWeatherOverviewInteractor.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//  
//

import UIKit
import Combine
import CoreLocation

class LocationsWeatherOverviewInteractor: PresenterToInteractorLocationsWeatherOverviewProtocol {

    // MARK: Properties
    private var addedAddressNames: [String] = []
    private var addressCoordinates: [CLLocationCoordinate2D] = []
    var presenter: InteractorToPresenterLocationsWeatherOverviewProtocol?

    var addressRepository = AddressRepository()

    private var locationManager: AnyCancellable?

    init() {
        setupBindings()
    }

    var makeLocationsWeatherOverviewPageViewController: UIPageViewController {
        return UIPageViewController()
    }
    func fetchCoordinates() {
        DispatchQueue.main.async { [self] in
            let storedAddresses = addressRepository.addresses
            for name in storedAddresses.filter({ !addedAddressNames.contains($0) }) {
                name.coordinate(completion: { [self] coordinates, _ in
                    if let coordinates = coordinates {
                        addressCoordinates.append(coordinates)
                        addedAddressNames.append(name)
                        presenter?.updateWeatherOverviewPage(coordinates: coordinates)
                    }
                })}
        }
    }

    //TODO: - move to main controller where repos are controlled
    //TODO: - fix bug here
    func setupBindings() {
//        locationManager = CLLocationManager.publishLocation()
//            .receive(on: RunLoop.main)
//            .sink(receiveValue: {[weak self] coordinates in
//                guard let self = self else { return }
//                print(coordinates)
//                coordinates.address(completion: { cityName, countryCode, _ in
//                    if let cityName = cityName, let countryCode = countryCode {
//                        print( "\(cityName), \(countryCode)")
//                        if self.addressRepository.addressExists(name: cityName, cityNames: self.addressRepository.addressStrings) {
//                            return
//                        }
//                        self.addAddress(coordinates: coordinates)
//                        self.addressRepository.addNewAddress(name: "\(cityName), \(countryCode)")
//                        refreshMainView = true
//                    }
//                })
//            })
    }

}
