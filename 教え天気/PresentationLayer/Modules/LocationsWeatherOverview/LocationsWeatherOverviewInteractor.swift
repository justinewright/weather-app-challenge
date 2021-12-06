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

    private var databaseRepositoryInteractor: LocationsWeatherOverviewToDatabase = Database.shared
    private var databaseRefreshInteractor: RefreshData = Database.shared
    private var cancellables: Set<AnyCancellable> = []

    init() {
        setupBindings()
    }

    func setupBindings() {
        let db = databaseRefreshInteractor
        db.refreshPub()
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global())
            .sink(receiveValue: { isDataFetched in
                if !isDataFetched {
                    return
                }
                DispatchQueue.main.async {
                    self.presenter?.fetchedPages(repos: self.databaseRepositoryInteractor.fetchWeatherEntitiesRepositories())
                }

            })
            .store(in: &cancellables)
    }

    func fetchPages() {
        Database.shared.updateData()
        self.presenter?.fetchedPages(repos: self.databaseRepositoryInteractor.fetchWeatherEntitiesRepositories())
    }

}
