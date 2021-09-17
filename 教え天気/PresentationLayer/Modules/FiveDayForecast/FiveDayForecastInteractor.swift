//
//  FiveDayForecastInteractor.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//  
//

import Foundation
import Combine

class FiveDayForecastInteractor: PresenterToInteractorFiveDayForecastProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterFiveDayForecastProtocol?
    var forecastWeatherPublisher: WeatherEntitiesRepositoryDailyForecastWeatherPublisher? {
        didSet(forecastPub) {
            bindForecastWeatherPublisher()
        }
    }

    private var cancellables: Set<AnyCancellable> = []

    init() {}

    private func bindForecastWeatherPublisher() {
        forecastWeatherPublisher?.forecastWeatherPub()
            .sink(receiveValue: { forecast in
                self.presenter?.updateFiveDayForecast(using: forecast)
            }).store(in: &cancellables)

    }
}
