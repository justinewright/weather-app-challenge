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
    var currentWeatherPublisher: WeatherEntitiesRepositoryCurrentWeatherPublisher? {
        didSet(currentPub) {
            bindCurrentWeatherPublisher()
        }
    }

    private var cancellables: Set<AnyCancellable> = []

    init() {}

    private func bindCurrentWeatherPublisher() {
        currentWeatherPublisher?.currentWeatherPub()
            .sink(receiveValue: { currentWeather in
                self.presenter?.updateCurrentWeather(using: currentWeather)
            }).store(in: &cancellables)

    }
}
