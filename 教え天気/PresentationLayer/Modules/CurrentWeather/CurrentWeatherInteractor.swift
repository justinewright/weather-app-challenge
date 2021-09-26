//
//  HourlyWeatherInteractor.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//  
//

import Foundation
import Combine

class CurrentWeatherInteractor: PresenterToInteractotCurrentWeatherProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterCurrentWeatherProtocol?
    private var repo: WeatherEntitiesRepositoryCurrentWeatherPublisher
    private var currentWeather: CurrentWeather
    private var cancellables: Set<AnyCancellable> = []

    init(weatherEntitiesRepository: WeatherEntitiesRepositoryCurrentWeatherPublisher) {
        repo = weatherEntitiesRepository
        currentWeather = CurrentWeather(dailyWeather: defaultDailyData.first!, currentWeather: defaultCurrentData)
        bindCurrentWeatherPublisher()
    }

    func fetchCurrentWeather() {
        presenter?.fetchedCurrentWeather(currentWeather: currentWeather )
    }

    private func bindCurrentWeatherPublisher() {
        repo.currentWeatherPub()
                .sink(receiveValue: { currentWeather in
                    self.currentWeather = currentWeather
                    self.presenter?.fetchedCurrentWeather(currentWeather:  self.currentWeather)
                }).store(in: &cancellables)

        }

}
