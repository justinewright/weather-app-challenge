//
//  DateHelper.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/31.
//

import Foundation

extension Date {

    func weekDay(unixTime: Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: date)
    }

    func todaysWeekDay() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }

    func todayFormated() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        dateFormatter.string(from: date)
        return dateFormatter.string(from: date)
    }

}
