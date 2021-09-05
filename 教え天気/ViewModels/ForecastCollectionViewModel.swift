//
//  ForecastCollectionViewModel.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/30.
//

import Foundation
import Combine

class ForecastCollectionViewModel {
    let forecastedDays: Int = 5
    private var repository: Repository

    @Published var weatherForecast: [WeatherModel] = []

    private var cancellables: Set<AnyCancellable> = []

    init(repository: Repository = Repository()) {
        self.repository = repository
        self.repository.$weatherForecast
            .map{$0}
            .assign(to: \.weatherForecast, on: self)
            .store(in: &cancellables)
        
        for _ in 0..<forecastedDays {
            weatherForecast.append(WeatherModel.default)
        }
    }
    
}
