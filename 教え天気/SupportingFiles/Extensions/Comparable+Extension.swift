//
//  Comparable+Extension.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/22.
//

import Foundation

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
