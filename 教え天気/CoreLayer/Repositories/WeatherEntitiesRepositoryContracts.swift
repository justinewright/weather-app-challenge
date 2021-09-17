//
//  WeatherEntitiesRepositoryContracts.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//

import Foundation
import Combine

protocol WeatherEntitiesRepositoryAddressPublisher {
    func addressPub()-> AnyPublisher<String, Never>
}

protocol WeatherEntitiesRepositoryCurrentWeatherPublisher {
    func currentWeatherPub() -> AnyPublisher<CurrentWeather, Never> 
}

protocol WeatherEntitiesRepositoryDailyForecastWeatherPublisher {
    func forecastWeatherPub() -> AnyPublisher<[DailyWeather], Never>
}

protocol WeatherEntitiesRepositoryRefresh {
    func refresh()
}
