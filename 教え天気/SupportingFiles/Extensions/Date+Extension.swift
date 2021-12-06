//
//  Date+Extension.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//

import Foundation

extension Date {

    func weekDay(unixTime: Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: date)
    }

    func hour(unixTime: Double, timeZone: String) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        return dateFormatter.string(from: date)
    }

    func hour(unixTime: Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.string(from: date)
    }

    var todaysWeekDay: String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }

    var todayFormated: String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        dateFormatter.string(from: date)
        return dateFormatter.string(from: date)
    }

}
