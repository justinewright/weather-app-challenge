//
//  FiveDayForecastView.swift
//  教え天気
//
//  Created by Justine Wright on 2021/10/19.
//

import UIKit

class FiveDayForecastWeatherView: UIView {
    
    private lazy var collectionView = ForecastCollectionView()
    
    init() {
        super.init(frame: .zero)

        setupView()

        collectionView.refresh(data: defaultDailyData.map{DailyWeather(dailyWeather: $0)} )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(delegate: ForecastCollectionViewDelegate) {
        collectionView.configure(delegate: delegate)
    }

    private func setupView() {
        addSubview(collectionView)
        setupConstraints()
    }

    private func setupConstraints() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}

extension FiveDayForecastWeatherView: ForecastCollectionViewDelegate {
    func selectedCellInformation(_ dailyWeather: DailyWeather) {

    }

}
