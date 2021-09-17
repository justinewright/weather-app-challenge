//
//  Double+Extension.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//

import Foundation

extension Double {
    var toCelcius: String {
        "\(String(format: "%0.0f", self))°C"
    }
}
