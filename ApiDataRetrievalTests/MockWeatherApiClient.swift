//
//  mockApiClient.swift
//  ApiDataRetrievalTests
//
//  Created by Justine Wright on 2021/09/02.
//

import Foundation
import Combine

class MockWeatherApiClient: WeatherApiClientProtocol {
    @Published var weatherData: WeatherData
    private var cancellables = Set<AnyCancellable>()
    let mockServer = PassthroughSubject<WeatherData, Error> ()

    init() {
        var daily: [Daily] = []
        for _ in 0..<5 {
            daily.append(Daily(dt: 0,
                               temp: Temperature(day: 0, min: 0, max: 0),
                               weather: [Weather(icon: "wifi.slash")]))

        }
        weatherData = WeatherData(timezone: "NA/Unavaliable", daily: daily)
    }

    func fetch(long: Double, lat: Double) {
        mockServer
            .sink { error in
                self.weatherData = self.getDefaultWeatherData()
            } receiveValue: { data in
                print(data)
                self.weatherData = data
            }.store(in: &cancellables)
    }

    func listen() -> AnyPublisher<WeatherData, Never> {
        $weatherData.eraseToAnyPublisher()
    }

    private func getDefaultWeatherData() -> WeatherData {
        var daily: [Daily] = []
        for _ in 0..<5 {
            daily.append(Daily(dt: 0,
                               temp: Temperature(day: 0, min: 0, max: 0),
                               weather: [Weather(icon: "-1")]))

        }
        return WeatherData(timezone: "NA/Unavaliable", daily: daily)
    }

}
