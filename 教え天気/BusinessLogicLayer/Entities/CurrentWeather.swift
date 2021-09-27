//
//  HourlyWeather.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//

import Foundation

struct CurrentWeather {
    let temperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    let icon: String
    let currentWeatherString: String = "現\r\n在"

    var conditionName: String {
        iconList[icon] ?? "wifi.slash"
    }

    var backgroundName: String {
        backgroundList[icon] ?? "empty"
    }

    let iconList: [String: String] =
        ["01d": "sun.max", "01n": "moon.stars",
         "02d": "cloud.sun", "02n": "cloud.moon",
         "03d": "cloud", "03n": "cloud",
         "04d": "cloud.fill", "04n": "cloud.fill",
         "09d": "cloud.drizzle", "09n": "cloud.drizzle",
         "10d": "cloud.sun.rain", "10n": "cloud.sun.rain",
         "11d": "cloud.bolt.rain", "11n": "cloud.bolt.rain",
         "13d": "snow", "13n": "snow",
         "50d": "cloud.fog", "50n": "cloud.fog",
         "-1": "wifi.slash"
        ]

    let backgroundList: [String: String] =
        ["01d": "clear", "01n": "clear",
         "02d": "fewClouds", "02n": "fewClouds",
         "03d": "cloudy", "03n": "cloudy",
         "04d": "cloudy", "04n": "cloudy",
         "09d": "heavyRain", "09n": "heavyRain",
         "10d": "rain", "10n": "rain",
         "11d": "thunder", "11n": "thunder",
         "13d": "snow", "13n": "snow",
         "50d": "fog", "50n": "fog",
         "-1": "empty"
        ]

    init(dailyWeather: Daily, currentWeather: Current) {
        temperature = currentWeather.temp
        minTemperature = dailyWeather.temp.min
        maxTemperature = dailyWeather.temp.max
        icon = currentWeather.weather[0].icon
    }
}
