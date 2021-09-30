//
//  Database.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/22.
//

import Foundation
import Combine
import CoreLocation

typealias LocationID = Int

class Database {

    // MARK: - Properties
    private var weatherRepositoriesLoadedCount: Int = 0
    private var weatherRepositories: [WeatherEntitiesRepository] = []
    private var addedLocations: [String] = []
    @Published private var updatePublisher: Bool = false
    private let loaded = PassthroughSubject<Bool, Never>()
    private var cancellables: Set<AnyCancellable> = []

    static let shared = Database()

    // MARK: - Initialization
    private init() {
//        bindUpdate()
//        updateData()
    }

    private func bindUpdate() {
        loaded
            .sink { self.updatePublisher = $0 }
            .store(in: &cancellables)
    }

    private func bindWeatherRepoLoaded(repoIsLoadedPub: WeatherEntitiesRepository) {
        repoIsLoadedPub.loadedPub()
            .sink(receiveValue: { [self] isLoaded in
                if !isLoaded {
                    return
                }
                if addedLocations.contains(repoIsLoadedPub.address) {
                    return
                }
                weatherRepositoriesLoadedCount += 1
                addedLocations.append(repoIsLoadedPub.address)
                if allHaveReposLoaded {
                    loaded.send(true)
                }
            })
            .store(in: &cancellables)
    }

    // MARK: - Public Methods
    func updateData() {
        updateWeatherRepositories()
    }

}

extension Database: LocationListToDatabase {
    func fetchAddresses() -> [String] {
        return AddressRepository.shared.addresses
    }

    func addAddress(_ address: String) {
        if AddressRepository.shared.addresses.contains(address) {
            return
        }
        let addressRepo = AddressRepository.shared
        addressRepo.add(newAddress: address)
        updateData()
    }
}

extension Database: LocationTrackerToDatabase {
    func addCurrentAddress(_ address: String) {
        if addedLocations.contains(address) || AddressRepository.shared.addresses.first == address {
            return
        }
        let addressRepo = AddressRepository.shared
        addressRepo.add(currentAddress: address)
        updateData()

    }
}

extension Database: LocationsWeatherOverviewToDatabase {
    func fetchWeatherEntitiesRepositories() -> [WeatherEntitiesRepository] {
        return weatherRepositories
    }
}

// TODO: - Publish errors
extension Database: RefreshData {
    func refreshPub() -> AnyPublisher<Bool, Never> {
        $updatePublisher.eraseToAnyPublisher()
    }
}

// MARK: - Private Updating Methods
private extension Database {

    private func updateWeatherRepositories() {
        weatherRepositoriesLoadedCount = 0
        weatherRepositories = []
        addAllSavedLocation()
        weatherRepositories.forEach { repo in
            repo.refresh()
        }
    }

    private func addAllSavedLocation() {
        AddressRepository.shared.addresses.forEach { address in
            address.coordinate { coordinates, _ in
                guard let lat = coordinates?.latitude, let lon = coordinates?.longitude else { return }
                let repos = WeatherEntitiesRepository.init(address: address, lat: lat, lon: lon)
                self.weatherRepositories.append(repos)
                self.bindWeatherRepoLoaded(repoIsLoadedPub: repos)
            }
        }
    }

    private var allHaveReposLoaded: Bool {weatherRepositoriesLoadedCount == AddressRepository.shared.addresses.count}

}
