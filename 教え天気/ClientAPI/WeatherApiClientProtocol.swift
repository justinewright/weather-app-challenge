//
//  WeatherApiClientProtocol.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/31.
//

import Foundation
import Combine

protocol WeatherApiClientProtocol {
    func fetch(long: Double, lat: Double)
    func listen() -> AnyPublisher<WeatherData, Never>
}
