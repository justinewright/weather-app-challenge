//
//  Details.swift
//  教え天気
//
//  Created by Justine Wright on 2021/12/06.
//

import Foundation

enum WeatherDetails: Int {
    case rain = 0
    case humidity = 1
    case pressure = 2
    case wind = 3
    case sunrise = 4
    case sunset = 5

}

struct Details {
    let header: String
    let imageName: String
    let info1: String
    let info1unit: String
    var info2: String? = nil
    var info2unit: String? = nil

    init(weatherDetails: WeatherDetails, dailyWeather: DailyWeather) {
        switch weatherDetails {
        case .rain:
            header = "rain"
            imageName = "drop.fill"
            info1  = "\(dailyWeather.rain ?? 0)"
            info1unit = "mm"
        case .humidity:
            header = "humidity"
            imageName = "gauge"
            info1 = "\(dailyWeather.humidity)"
            info1unit = "%"
        case .pressure:
            header = "pressure"
            imageName = "humidity"
            info1 = "\(Int(dailyWeather.pressure))"
            info1unit = "hPa"
        case .wind:
            header = "wind"
            imageName = "wind"
            info1 = "\(dailyWeather.windSpeed)"
            info2 = "\(dailyWeather.windDirection)"
            info1unit = "m/s"
            info2unit = "°"
        case .sunrise:
            header = "sunrise"
            imageName = "sunrise.fill"
            info1 = "\( Date().hour(unixTime: dailyWeather.sunriseTime, timeZone: dailyWeather.timeZone))"
            info1unit = "am"
        case .sunset:
            header = "sunset"
            imageName = "sunset.fill"
            info1 = "\(Date().hour(unixTime: dailyWeather.sunsetTime, timeZone: dailyWeather.timeZone))"
            info1unit = "pm"
        }
    }
}
