//
//  Constants.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/04.
//

import Foundation

struct Constant {
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
}
