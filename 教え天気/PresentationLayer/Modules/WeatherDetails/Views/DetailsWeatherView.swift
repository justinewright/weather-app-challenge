//
//  DetailsWeatherView.swift
//  教え天気
//
//  Created by Justine Wright on 2021/10/19.
//

import UIKit

final class DetailsWeatherView: UIView {
    lazy var collectionView = ReusableCollectionView(cellWidth: DetailsCell.flexibleWidth, cellHeight: DetailsCell.flexibleWidth)
    let dataSource = WeatherDetailsDataSource()

    init() {
        super.init(frame: .zero)
        setupView()

        DispatchQueue.main.async {
            self.collectionView.register(cellType: DetailsCell.self)
            self.collectionView.collectionView.dataSource = self.dataSource
            self.dataSource.config(data: DailyWeather(dailyWeather: defaultDailyData.first!))
        }
        collectionView.refresh()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle Methods

    func setupView() {
        addSubview(collectionView)
        setupConstraints()
    }

    func setupConstraints() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
