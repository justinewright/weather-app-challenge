//
//  HourlyWeatherView.swift
//  教え天気
//
//  Created by Justine Wright on 2021/10/19.
//

import UIKit

final class HourlyWeatherView: UIView {
    lazy var collectionView = ReusableCollectionView(cellWidth: HourlyCell.flexibleWidth, cellHeight: HourlyCell.flexibleHeight)
    let dataSource = HourlyForecastDataSource()

    init() {
        super.init(frame: .zero)
        setupView()

        DispatchQueue.main.async {
//            self.collectionView.register(cellType: HourlyCell.self)
            self.collectionView.register(cellType: HourlyCell.self)
            self.collectionView.collectionView.dataSource = self.dataSource
            self.dataSource.config(data: defaultHourlyData.map { HourlyWeather(hourlyWeather: $0, timeZone: defaultTimeZone)
            })
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
