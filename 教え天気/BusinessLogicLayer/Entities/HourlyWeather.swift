//
//  HourlyWeather.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/29.
//

import Foundation

struct HourlyWeather {
    var temperature: Double = 0
    var hour: String = "0"
    let icon: String

    var conditionName: String {
        iconList[icon] ?? "cloud"
    }

    init(hourlyWeather: Hourly, timeZone: String = "") {
        temperature = hourlyWeather.temp
        hour = Date().hour(unixTime: hourlyWeather.dt, timeZone: timeZone)
        icon = hourlyWeather.weather[0].icon
    }
}
