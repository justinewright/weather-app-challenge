//
//  WeatherModel.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/27.
//

import Foundation

struct WeatherModel {
    let temperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    let icon: String
    var dayOfWeekEnglish: String = ""
    var dayOfWeekJapanese: String = ""

    var temperatureString: String {
        "\(String(format: "%0.0f", temperature))°C"
    }
    
    var minTemperatureString: String {
        "\(String(format: "%0.0f", minTemperature))°C"
    }

    var maxTemperatureString: String {
        "\(String(format: "%0.0f", maxTemperature))°C"
    }

    var conditionName: String {
        iconList[icon] ?? "cloud"
    }

    var backgroundName: String {
        backgroundList[icon] ?? "cloud"
    }
    
    let weekdaysJapanese: [String: String] = [
        "Mon":"月\r\n曜\r\n日",
        "Tue":"火\r\n曜\r\n日",
        "Wed":"水\r\n曜\r\n日",
        "Thu":"木\r\n曜\r\n日",
        "Fri":"金\r\n曜\r\n日",
        "Sat":"土\r\n曜\r\n日",
        "Sun":"日\r\n曜\r\n日"
    ]

    let iconList: [String: String] =
        ["01d":"sun.max","01n":"moon.stars",
         "02d":"cloud.sun","02n":"cloud.moon",
         "03d":"cloud","03n":"cloud",
         "04d":"cloud.fill","04n":"cloud.fill",
         "09d":"cloud.drizzle","09n":"cloud.drizzle",
         "10d":"cloud.sun.rain","10n":"cloud.sun.rain",
         "11d":"cloud.bolt.rain","11n":"cloud.bolt.rain",
         "13d":"snow","13n":"snow",
         "50d":"cloud.fog","50n":"cloud.fog",
         "-1": "wifi.slash"
        ]

    let backgroundList: [String: String] =
        ["01d":"clear","01n":"clear",
         "02d":"fewClouds","02n":"fewClouds",
         "03d":"cloudy","03n":"cloudy",
         "04d":"cloudy","04n":"cloudy",
         "09d":"heavyRain","09n":"heavyRain",
         "10d":"rain","10n":"rain",
         "11d":"thunder","11n":"thunder",
         "13d":"snow","13n":"snow",
         "50d":"fog","50n":"fog",
         "-1": "empty"
        ]

    static let `default` = WeatherModel(temperature: 0,  minTemperature: 0, maxTemperature: 0, icon: "-1", dt: 1630490400)
    
    init(temperature: Double, minTemperature: Double, maxTemperature: Double, icon: String, dt: Double) {
        self.temperature = temperature
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
        self.icon = icon
        dayOfWeekEnglish = Date().weekDay(unixTime: dt)
        dayOfWeekJapanese = weekdaysJapanese[dayOfWeekEnglish] ?? ""
    }

    init(dailyWeather: Daily) {
        temperature = dailyWeather.temp.day
        minTemperature = dailyWeather.temp.min
        maxTemperature = dailyWeather.temp.max
        icon = dailyWeather.weather[0].icon
        dayOfWeekEnglish = Date().weekDay(unixTime: dailyWeather.dt)
        dayOfWeekJapanese = weekdaysJapanese[dayOfWeekEnglish] ?? ""
    }
}

