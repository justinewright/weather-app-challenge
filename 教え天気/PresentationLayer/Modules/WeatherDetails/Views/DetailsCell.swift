//
//  DetailsCell.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/30.
//

import UIKit

class DetailsCell: UICollectionViewCell, Reusable {
    static let flexibleWidth: CGFloat = UIScreen.main.bounds.height * 0.10
    private var frameSize: CGRect = CGRect(x: 0, y: 0, width: DetailsCell.flexibleWidth, height: DetailsCell.flexibleWidth)

    private let cornerRadius: CGFloat = 5

    private lazy var squareView: UIView = {
        let view = UIView(frame: frameSize)
        view.backgroundColor = .black
        view.layer.cornerRadius = cornerRadius
        return view
    }()

    private lazy var headerTitleLabel: UILabel = {
        let headerTitleLabel = UILabel().LightGray.SystemFont12
        headerTitleLabel.text = "rain"
        headerTitleLabel.textAlignment = .center
        return headerTitleLabel
    }()

    private lazy var headerImageView: UIImageView = {
        let headerImageView = UIImageView()
        headerImageView.image = UIImage(systemName: "drop.fill")
        return headerImageView
    }()

    private lazy var headerHorizontalStackView: UIStackView = {
        let headerHorizontalStackView = UIStackView(arrangedSubviews: [headerTitleLabel, headerImageView])
        headerHorizontalStackView.axis = .horizontal
        return headerHorizontalStackView
    }()

    private lazy var bodyVerticalStack: UIStackView = {
        let bodyVerticalStack = UIStackView()
        bodyVerticalStack.axis = .vertical
        bodyVerticalStack.distribution = .equalCentering
        bodyVerticalStack.alignment = .center
        return bodyVerticalStack
    }()

    private lazy var info1HorizontalStackView: UIStackView = {
        let info1HorizontalStackView = UIStackView(arrangedSubviews: [info1NumberLabel, info1MetricsLabel])
        info1HorizontalStackView.axis = .horizontal
        info1HorizontalStackView.alignment = .center
        info1HorizontalStackView.distribution = .equalSpacing
        return info1HorizontalStackView
    }()

    private lazy var info2HorizontalStackView: UIStackView = {
        let info2HorizontalStackView = UIStackView(arrangedSubviews: [info1NumberLabel, info1MetricsLabel])
        info2HorizontalStackView.axis = .horizontal
        return info2HorizontalStackView
    }()

    private lazy var info1NumberLabel: UILabel = {
        let info1NumberLabel = UILabel().White.SystemFont18
        info1NumberLabel.textAlignment = .right
        info1NumberLabel.text = "000"
        return info1NumberLabel
    }()

    private lazy var info2NumberLabel: UILabel = {
        let info2NumberLabel = UILabel().White.SystemFont18
        info2NumberLabel.textAlignment = .center
        info2NumberLabel.text = "000"
        return info2NumberLabel
    }()

    private lazy var info1MetricsLabel: UILabel = {
        let info1MetricsLabel = UILabel().LightGray.SystemFont12
        info1MetricsLabel.textAlignment = .right
        info1MetricsLabel.text = "mm"
        return info1MetricsLabel
    }()

    private lazy var info2MetricsLabel: UILabel = {
        let info2MetricsLabel = UILabel().LightGray.SystemFont12
        info2MetricsLabel.textAlignment = .right
        return info2MetricsLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }

    private func setupView() {
        backgroundView = UIView()
        backgroundView!.addSubview(squareView)
        contentView.addSubview(headerHorizontalStackView)
        contentView.addSubview(bodyVerticalStack)
        bodyVerticalStack.addArrangedSubview(info1HorizontalStackView)
        
        setupConstraints()
    }

    private func setupConstraints() {
        setupHeaderConstraints()
        setupBodyConstraints()
    }

    private func setupHeaderConstraints() {
        headerHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerHorizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            headerHorizontalStackView.heightAnchor.constraint(equalToConstant: DetailsCell.flexibleWidth * 0.2),
            headerHorizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerHorizontalStackView.widthAnchor.constraint(equalToConstant: DetailsCell.flexibleWidth - 10)
        ])
    }

    private func setupBodyConstraints() {
        bodyVerticalStack.translatesAutoresizingMaskIntoConstraints = false
        info1HorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bodyVerticalStack.topAnchor.constraint(equalTo: headerHorizontalStackView.bottomAnchor, constant: 5),
            bodyVerticalStack.heightAnchor.constraint(equalToConstant: DetailsCell.flexibleWidth * 0.5),
            bodyVerticalStack.widthAnchor.constraint(equalToConstant: DetailsCell.flexibleWidth ),
            info1HorizontalStackView.widthAnchor.constraint(equalToConstant:  DetailsCell.flexibleWidth - 20)
            ])
    }

    public func update(dailyWeather: DailyWeather) {

    }

}
