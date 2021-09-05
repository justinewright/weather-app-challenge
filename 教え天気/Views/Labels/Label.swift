//
//  Label.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/30.
//

import UIKit

class Label: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.initialize()
    }

    init() {
        super.init(frame: .zero)

        self.initialize()
    }

    func initialize() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
