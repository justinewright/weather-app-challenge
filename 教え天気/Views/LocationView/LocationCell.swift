//
//  LocationCell.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/06.
//

import UIKit

class LocationCell: UICollectionViewCell {
    var label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }

    private func setupView() {
        label.text = "Hello"
        label.sizeToFit()
        self.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
        backgroundColor = .gray
//        self.bounds = CGRect(x: 0, y: 0 , width: 300, height: 30)
//        setupConstraints()
    }

    private func setupConstraints() {
//        labe
    }

    public func setup(text: String) {
        label.text = text
    }

}
