//
//  MainViewModel.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/02.
//

import Foundation
import Combine

class MainViewModel {
    private var repository: Repository

    var locationViewModel: LocationViewModel!
    var todaysAverageTemperatureViewModel: TodaysAverageTemperatureViewModel!
    var forecastCollectionViewModel: ForecastCollectionViewModel!

    @Published var backgroundImage: String = "clear"

    private var cancellables: Set<AnyCancellable> = []

    init(repository: Repository = Repository()) {
        self.repository = repository
        self.repository.$weatherForecast
            .receive(on: DispatchQueue.main)
            .sink { self.backgroundImage = $0.first?.backgroundName ?? "clear"}
            .store(in: &cancellables)

        locationViewModel = .init(repository: self.repository)
        todaysAverageTemperatureViewModel = .init(repository: self.repository)
        forecastCollectionViewModel = .init(repository: self.repository)

    }
}
