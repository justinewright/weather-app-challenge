//
//  TextView.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/30.
//

import Foundation

class LocationView: UIView {
    private var locationLabel: MediumWhiteLabel!
    private var todaysAverageWeatherView: TodaysAverageWeatherView!
    private var forecastCollectionView: ForecastCollectionView!

    private var todaysWeather = WeatherModel.default

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureLocationLabel()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLocationLabel() {
        locationLabel = MediumWhiteLabel()
        locationLabel.backgroundColor = .blue
        locationLabel.text = "Johannesburg, SA"
        locationLabel.textAlignment = .center

        self.addSubview(locationLabel)
        var newSafeArea = UIEdgeInsets(top: self.safeAreaInsets.top, left: 0, bottom: 0, right: 0)

        locationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        locationLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true

//        locationLabel.safeAreaInsets = .init(top: 20, left: 0, bottom: 0, right: 0)
    }

    private func configureTodaysAverageWeatherView() {

    }

    private func configureForecastCollectionView() {

    }

}
