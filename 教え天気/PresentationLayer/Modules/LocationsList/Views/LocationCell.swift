//
//  LocationCell.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/16.
//

import UIKit

class LocationCell: UICollectionViewCell {
    var label = UILabel()

    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                UIView.animate(withDuration: 0.3) {
                    self.backgroundColor = .white
                }
            } else {
                UIView.animate(withDuration: 0.3) { 
                    self.backgroundColor = .lightGray
                }
            }
        }
    }
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
        self.backgroundColor = .lightGray
        setupConstraints()
    }

    private func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }

    public func setup(text: String) {
        label.text = text
    }

}
