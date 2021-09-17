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
    @Published private var addressPublisher: String = ""
    @Published var currentWeatherPublisher: CurrentWeather
    @Published var dailyWeatherForecastPublisher: [DailyWeather] = []

    let address = PassthroughSubject<String, Never>()
    let dailyWeatherForecast = PassthroughSubject<[DailyWeather], Never>()
    let currentWeather = PassthroughSubject<CurrentWeather, Never>()

    private var cancellables: Set<AnyCancellable> = []
    private var locationManager: AnyCancellable!
    private var weatherApiClient: WeatherApiClientProtocol!

    private var lat: Double = 0
    private var lon: Double = 0

    init(weatherApiClient: WeatherApiClientProtocol = OpenWeatherMapsOneCallApiClient(), lat: Double, lon: Double) {
        self.weatherApiClient = weatherApiClient
        currentWeatherPublisher = CurrentWeather(dailyWeather: defaultDailyData.first!, currentWeather: defaultCurrentData)

        setupBindings()
        self.lat = lat
        self.lon = lon
//        weatherApiClient.fetch(long: lon, lat: lat)
    }

    fileprivate func setupBindings() {
        bindRepositoryToApi()
        bindAddressPublisher()
        bindCurrentWeatherPublisher()
        bindDailyForecastPublisher()
    }

    fileprivate func bindRepositoryToApi() {
        weatherApiClient.listen()
            .sink(receiveValue: { weatherData in
                self.publish(weatherData: weatherData)
            })
            .store(in: &cancellables)
    }

    fileprivate func bindAddressPublisher() {
        address
            .receive(on: DispatchQueue.main)
            .assign(to: \.addressPublisher, on: self)
            .store(in: &cancellables)
    }

    fileprivate func bindCurrentWeatherPublisher() {
        currentWeather
            .receive(on: DispatchQueue.main)
            .assign(to: \.currentWeatherPublisher, on: self)
            .store(in: &cancellables)
    }

    fileprivate func bindDailyForecastPublisher() {
        dailyWeatherForecast
            .receive(on: DispatchQueue.main)
            .assign(to: \.dailyWeatherForecastPublisher, on: self)
            .store(in: &cancellables)
    }
    private func publish(weatherData: WeatherData) {
        publishAddress(weatherData: weatherData)
        publishCurrentWeather(weatherData: weatherData)
        publishDailyForecast(weatherData: weatherData)
    }

    private func publishAddress(weatherData: WeatherData) {
        CLLocationCoordinate2D(latitude: weatherData.lat, longitude: weatherData.lon).address{ city, cityCode, _ in
            guard let newCity = city, let countryCode = cityCode  else {
                return
            }
            self.address.send("\(newCity), \(countryCode)")
        }
    }

    private func publishDailyForecast(weatherData: WeatherData) {
        dailyWeatherForecast.send(weatherData.daily.compactMap(DailyWeather.init))
    }

    private func publishCurrentWeather(weatherData: WeatherData) {
        currentWeather.send(CurrentWeather(dailyWeather: weatherData.daily.first!, currentWeather: weatherData.current))
    }

}

extension WeatherEntitiesRepository: WeatherEntitiesRepositoryAddressPublisher {

    func addressPub() -> AnyPublisher<String, Never> {
        $addressPublisher
//            .debounce(for: 5, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }

}

extension WeatherEntitiesRepository: WeatherEntitiesRepositoryCurrentWeatherPublisher {

    func currentWeatherPub() -> AnyPublisher<CurrentWeather, Never> {
        $currentWeatherPublisher
//            .debounce(for: 5, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }

}

extension WeatherEntitiesRepository: WeatherEntitiesRepositoryDailyForecastWeatherPublisher {

    func forecastWeatherPub() -> AnyPublisher<[DailyWeather], Never> {
        $dailyWeatherForecastPublisher
//            .debounce(for: 5, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }

}

extension WeatherEntitiesRepository: WeatherEntitiesRepositoryRefresh {
    func refresh() {
        weatherApiClient.fetch(long: lon, lat: lat)
    }
}
