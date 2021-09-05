//
//  TodaysAverageTemperatureViewModel.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/31.
//

import Foundation
import Combine

class TodaysAverageTemperatureViewModel {
    private var repository: Repository

    @Published var todaysWeather: WeatherModel = WeatherModel.default

    private var cancellables: Set<AnyCancellable> = []

    init(repository: Repository = Repository()) {
        self.repository = repository
        self.repository.$weatherForecast
            .map{ $0.first ?? WeatherModel.default }
            .assign(to: \.todaysWeather, on: self)
            .store(in: &cancellables)
    }
}

