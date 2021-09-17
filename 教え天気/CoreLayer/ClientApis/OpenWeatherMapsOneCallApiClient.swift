//
//  OpenWeatherMapsOneCallApiClient.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//

import Foundation
import Combine

class OpenWeatherMapsOneCallApiClient: WeatherApiClientProtocol {
    @Published var weatherData: WeatherData
    private var cancellables = Set<AnyCancellable>()
    private let apiURL = "https://api.openweathermap.org/data/2.5/onecall"
    private let appIDParam = "appid=cc6410932cff63f7d50d5c52d6ea4903"
    private let unitsParam = "units=metric"
    private let excludeParams = "exclude=hourly,minutely,alerts"

    init() {
        weatherData = WeatherData(lat: 0, lon: 0, daily: defaultDailyData, current: defaultCurrentData)
    }

    func fetch(long: Double, lat: Double) {
        cancellables.forEach { $0.cancel() }
        if let url = URL(string: apiLink(long: long, lat: lat)) {
            URLSession
                .DataTaskPublisher(request: URLRequest(url: url),
                                   session: URLSession(configuration: .default))
                .retry(3)
                .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                        // todo alert
                        self.weatherData = defaultWeatherData
                        throw URLError(.badServerResponse)
                    }
                    return element.data
                }
                .decode(type: WeatherData.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { error in
                    print("Subscription completed with error \(error)")
                }, receiveValue: { self.weatherData = $0 }
                )
                .store(in: &cancellables)
            }

    }

    func listen() -> AnyPublisher<WeatherData, Never> {
        $weatherData.eraseToAnyPublisher()
    }

    private func apiLink(long: Double, lat: Double) -> String {
        return "\(apiURL)?\(appIDParam)&lat=\(lat)&lon=\(long)&\(unitsParam)&\(excludeParams)"
    }

}

var defaultWeatherData: WeatherData {
    let daily = defaultDailyData
    let current = defaultCurrentData

    return WeatherData(lat: 0, lon: 0, daily: daily, current: current)
}

var defaultDailyData: [Daily] {
    var daily: [Daily] = []
    for _ in 0..<5 {
        daily.append(Daily(dt: 0, sunrise: 0, sunset: 0,
                           temp: Temperature(day: 0, min: 0, max: 0, morn: 0, eve: 0),
                           weather: [Weather(icon: "-1")]))
    }
    return daily
}

var defaultCurrentData: Current {
    return Current(dt: 0, temp: 0, weather: [Weather(icon: "-1")])
}
