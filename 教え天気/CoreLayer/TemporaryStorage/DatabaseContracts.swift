//
//  DatabaseContracts.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/23.
//

import Combine

protocol LocationListToDatabase {
    func addAddress(_ address: String)
    func fetchAddresses() -> [String]
}

protocol LocationTrackerToDatabase {
    func addCurrentAddress(_ address: String)
}

protocol LocationsWeatherOverviewToDatabase {
    func fetchWeatherEntitiesRepositories() -> [WeatherEntitiesRepository]
}

protocol RefreshData {
    func refreshPub() -> AnyPublisher<Bool, Never>
}
