//
//  Repository.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/31.
//

import Foundation
import CoreLocation
import Combine

class Repository {
    @Published var weatherForecast: [WeatherModel] = []
    let city = PassthroughSubject<String, Never>()
    
    private var cancellables: Set<AnyCancellable> = []
    private var locationManager: AnyCancellable!
    private var weatherApiClient: WeatherApiClientProtocol!

    init(weatherApiClient: WeatherApiClientProtocol = OpenWeatherMapsApiClient(), coordinates: CLLocationCoordinate2D? = nil) {
        self.weatherApiClient = weatherApiClient
        weatherApiClient.listen()
            .map{ weatherData in
                self.parseJSON(weatherData: weatherData)
            }
            .assign(to: \.weatherForecast, on: self)
            .store(in: &cancellables)

        if let coordinates = coordinates {
            weatherApiClient.fetch(long: coordinates.longitude, lat: coordinates.latitude)
        } else {
        locationManager = CLLocationManager.publishLocation()
            .sink(receiveValue: { self.onLocationUpdate(coordinates: $0) })
        }
    }

    private func onLocationUpdate(coordinates: CLLocationCoordinate2D) {
        weatherApiClient.fetch(long: coordinates.longitude, lat: coordinates.latitude)
    }

    private func parseJSON(weatherData: WeatherData) -> [WeatherModel] {
        weatherForecast = []
        let timezone = weatherData.timezone.split(separator: "/")
        city.send(String(timezone[1]))
        return weatherData.daily.compactMap(WeatherModel.init)
    }
}
