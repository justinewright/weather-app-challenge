//
//  WeatherData.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//

import Foundation

struct WeatherData: Codable {
    let lat: Double
    let lon: Double
    let daily: [Daily]
    let current: Current
}

struct Current: Codable {
    let dt: Double
    let temp: Double
    let weather: [Weather]
}

struct Daily: Codable {
    let dt: Double
    let sunrise: Double
    let sunset: Double
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
    let morn: Double
    let eve: Double
}
