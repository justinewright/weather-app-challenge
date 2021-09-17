//
//  WeatherApiClientProtocol.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//

import Foundation
import Combine

protocol WeatherApiClientProtocol {
    func fetch(long: Double, lat: Double)
    func listen() -> AnyPublisher<WeatherData, Never>
}
