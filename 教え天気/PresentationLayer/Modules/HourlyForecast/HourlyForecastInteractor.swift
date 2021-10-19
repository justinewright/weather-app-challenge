//
//  HourlyForecastInteractor.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/29.
//  
//

import Foundation
import Combine

class HourlyForecastInteractor: PresenterToInteractorHourlyForecastProtocol {
    // MARK: Properties
    var presenter: InteractorToPresenterHourlyForecastProtocol?
    private var repo: WeatherEntitiesRepositoryHourlyWeatherPublisher
    private var hourlyWeather: [HourlyWeather]
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initialization
    init(repo: WeatherEntitiesRepositoryHourlyWeatherPublisher) {
        self.repo = repo
        bindCurrentHourlyPublisher()
    }

    func fetchCurrentWeather() {
        presenter?.fetchedHourlyWeather(hourlyWeather: hourlyWeather)
    }

    private func bindCurrentHourlyPublisher() {
        repo.hourlyWeatherPub()
            .sink(receiveValue: { hourlyWeather in
                self.hourlyWeather = hourlyWeather
                self.presenter?.fetchedCurrentWeather(currentWeather:  self.hourlyWeather)
            }).store(in: &cancellables)

    }
}
