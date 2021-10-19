//
//  BaseView.swift
//  教え天気
//
//  Created by Justine Wright on 2021/10/19.
//

import UIKit

protocol BaseViewProtocol {
    func configure(withContent content: Any)
}

class BaseView: UIView {

    // MARK: - Parameters
    private var titleLabel: UILabel!
    private var contentView: UIView!
    private var padding: CGFloat = 10

    // MARK: - Initialization
    init(titleText: String, content: UIView) {
        super.init(frame: .zero)
        addTitleLabel(titleText)
        addContentView(content)
        style()
    }

    private func addContentView(_ content: UIView) {
        contentView = content
        addSubview(contentView)
        addContentViewConstraints()
    }

    private func addContentViewConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: padding),
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }

    private func addTitleLabel(_ title: String) {
        titleLabel = UILabel().SystemFont14.LightGray
        titleLabel.text =  title
        backgroundColor = UIColor(named: "dark gray")
        titleLabel.backgroundColor = .black
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
        addTitleLabelConstraints()
    }

    private func addTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            titleLabel.widthAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func style() {
        backgroundColor = UIColor(named: "dark gray")
        layer.cornerRadius = 10
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
