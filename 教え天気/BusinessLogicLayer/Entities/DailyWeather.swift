//
//  WeatherEntity.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//

import Foundation

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
     "-1": "wifi.slash",
     "rain": "drop.fill",
     "humidity": "humidity.fill",
     "wind": "wind",
     "pressure": "gauge",
     "sunrise": "sunset",
     "sunset": "sunrise"
    ]

struct DailyWeather {
    var sunriseTime: Double = 0
    var sunsetTime: Double = 0

    var minTemperature: Double = 0
    var maxTemperature: Double = 0

    var rain: Double? = 0
    var humidity: Double = 0
    var windSpeed: Double = 0
    var windDirection: Double = 0
    var pressure: Double = 0
    let timeZone: String 

    let icon: String
    var dayOfWeekEnglish: String = ""
    var dayOfWeekJapanese: String = ""
    let fivedayDailyWeatherString: String = "五\r\n日\r\n間"

    var conditionName: String {
        iconList[icon] ?? "cloud"
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

    init(dailyWeather: Daily, timeZone: String = "") {
        self.minTemperature = dailyWeather.temp.min
        self.maxTemperature = dailyWeather.temp.max
        self.sunriseTime = dailyWeather.sunrise
        self.sunsetTime = dailyWeather.sunset
        self.rain = dailyWeather.rain
        self.humidity = dailyWeather.humidity
        self.pressure = dailyWeather.pressure
        self.windSpeed = dailyWeather.wind_speed
        self.windDirection = dailyWeather.wind_deg
        self.dayOfWeekEnglish = Date().weekDay(unixTime: Double(dailyWeather.dt))
        self.dayOfWeekJapanese = weekdaysJapanese[dayOfWeekEnglish]!
        self.timeZone = timeZone
        icon = dailyWeather.weather[0].icon
    }
}
