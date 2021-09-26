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
    private var repo: WeatherEntitiesRepositoryDailyForecastWeatherPublisher
    private var cancellables: Set<AnyCancellable> = []
    private var fiveDayForecast: [DailyWeather] = []

    init(repo: WeatherEntitiesRepositoryDailyForecastWeatherPublisher) {
        self.repo = repo
        bindForecastWeatherPublisher()
    }
    
    private func bindForecastWeatherPublisher() {
        repo.forecastWeatherPub()
            .sink(receiveValue: { forecast in
                self.fiveDayForecast = forecast
                self.presenter?.fetchedForecast(dailyForecast: self.fiveDayForecast)
            }).store(in: &cancellables)

    }

    func fetchForecast() {
        presenter?.fetchedForecast(dailyForecast: fiveDayForecast)
    }
}
