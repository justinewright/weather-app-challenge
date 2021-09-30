//
//  UIView+Extension.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//

import UIKit
import SwiftUI

extension UIView {
    func makeLargeView(anchorTo view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
            ,
            heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.25)
            ]
        )
    }

    func makeMediumView(anchorTo view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
            ,
            heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.13)
            ]

        )
    }

    func makeSmallView(anchorTo view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.7)
            ,
            heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.7)
            ]

        )
    }
    
    func edgeTo(view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

}
