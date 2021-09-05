//
//  WeatherData.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/31.
//

import Foundation

struct WeatherData: Codable {
    let timezone: String
    let daily: [Daily]
}

struct Daily: Codable {
    let dt: Double
    let temp: Temperature
    let weather: [Weather]
}

struct Weather: Codable {
    let icon: String
}

struct Temperature: Codable {
    let day: Double
    let min: Double
    let max: Double
}

