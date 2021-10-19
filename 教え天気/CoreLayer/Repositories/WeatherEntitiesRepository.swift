//
//  OpenWeatherMapsOneShotApiRepository.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//

import Foundation
import CoreLocation
import Combine

class WeatherEntitiesRepository {

    @Published private(set) var loadedPublisher: Bool = false
    @Published private var hourlyWeatherPublisher: [HourlyWeather] = []
    @Published private var currentWeatherPublisher: CurrentWeather
    @Published private var dailyWeatherForecastPublisher: [DailyWeather] = []
    private let loaded = PassthroughSubject<Bool, Never>()

    private var weatherApiClient: WeatherApiClientProtocol!
    private var weatherData: WeatherData!
    private var cancellables: Set<AnyCancellable> = []

    private var lat: Double = 0
    private var lon: Double = 0
    private(set) var address: String = ""

    init(weatherApiClient: WeatherApiClientProtocol = OpenWeatherMapsOneCallApiClient(), address: String, lat: Double, lon: Double) {
        self.weatherApiClient = weatherApiClient
        currentWeatherPublisher = CurrentWeather(dailyWeather: defaultDailyData.first!, currentWeather: defaultCurrentData)


        setupBindings()
        weatherApiClient.fetch(long: lon, lat: lat)
        self.address = address
        self.lat = lat
        self.lon = lon
    }

    fileprivate func setupBindings() {
        bindRepositoryToApi()
    }

    fileprivate func bindRepositoryToApi() {
        weatherApiClient.listen()
            .sink { weatherData in
                self.currentWeatherPublisher = CurrentWeather(dailyWeather: weatherData.daily.first!, currentWeather: weatherData.current)
                self.dailyWeatherForecastPublisher = weatherData.daily.compactMap(DailyWeather.init)
                self.publish(weatherData: weatherData)
                
            }.store(in: &cancellables)

        loaded
            .assign(to: \.loadedPublisher, on: self)
            .store(in: &cancellables)
    }

    private func publish(weatherData: WeatherData) {
        self.weatherData = weatherData
        loadedPublisher = true
    }
}

extension WeatherEntitiesRepository: WeatherEntitiesRepositoryRefresh {
    func refresh() {
        weatherApiClient.fetch(long: lon, lat: lat)
    }
}

extension WeatherEntitiesRepository: WeatherEntitiesRepositoryLoadedPublisher {
    func loadedPub() -> AnyPublisher<Bool, Never> {
        $loadedPublisher
            .eraseToAnyPublisher()
    }
}

extension WeatherEntitiesRepository: WeatherEntitiesRepositoryCurrentWeatherPublisher {

    func currentWeatherPub() -> AnyPublisher<CurrentWeather, Never> {
        $currentWeatherPublisher
            .eraseToAnyPublisher()
    }

}

extension WeatherEntitiesRepository: WeatherEntitiesRepositoryDailyForecastWeatherPublisher {

    func forecastWeatherPub() -> AnyPublisher<[DailyWeather], Never> {
        $dailyWeatherForecastPublisher
            .eraseToAnyPublisher()
    }

}

extension WeatherEntitiesRepository: WeatherEntitiesRepositoryAddressProtocol {
    func fetch() -> String {
        return address
    }
}

extension WeatherEntitiesRepository: WeatherEntitiesRepositoryHourlyWeatherPublisher {
    func hourlyWeatherPub() -> AnyPublisher<[HourlyWeather], Never> {
        $hourlyWeatherPublisher
            .eraseToAnyPublisher()
    }
}
