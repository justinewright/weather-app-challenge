//
//  UserDefaults+Extension.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//

import Foundation

extension UserDefaults {
    @objc var addresses: [String] {
        get {
            return stringArray(forKey: "addresses") ?? [String]()
        }
        set {
            set(newValue, forKey: "addresses")
        }
    }
}
