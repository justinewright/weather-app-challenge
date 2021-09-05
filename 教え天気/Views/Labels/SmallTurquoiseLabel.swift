//
//  SmallTurquoiseLabel.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/30.
//

import Foundation
import UIKit

class SmallGrayLabel: Label {
    override func initialize() {
        super.initialize()
        self.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 45)
        self.font = .systemFont(ofSize: 12)
        self.textColor = .lightGray
    }
}
