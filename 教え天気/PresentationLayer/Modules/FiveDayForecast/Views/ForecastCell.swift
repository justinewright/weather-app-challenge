//
//  ForecastCell.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//

import Foundation
import UIKit

class ForecastCell: UICollectionViewCell {
    static let width: CGFloat = 226
    static let flexibleWidth: CGFloat = UIScreen.main.bounds.height * 0.10
    private var weatherIconImageView = UIImageView()
    private var backgroundImageView: UIImageView!
    private var temperatureLabelStack: UIStackView!
    private var lowTemperatureLabel: UILabel!
    private var highTemperatureLabel: UILabel!

    private var englishWeekdayLabel: UILabel!
    private var japaneseWeekdayLabel: UILabel!
    private var frameSize: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height * 0.10, height: UIScreen.main.bounds.height * 0.10)
    private var backgroundImageName = "forecastCell"
    private var emptyTemperatureString = "__°C"
    private var defaultIconName = "wifi.slash"
    private var defaultEngWeekdayString = "-"
    private var defaultJapWeekdayString = "-\r\n曜\r\n日"
    private var distanceToCenter: CGFloat = 50
    private var ratio: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        ratio = UIScreen.main.bounds.height * 0.10/ForecastCell.width
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }

    private func setupView() {
        setupBackgroundImageView()
        setupSelectedBackgroundImageView()
        setupWeatherIconImageView()
        setupEnglishWeekdayLabel()
        setupJapaneseWeekdayLabel()
        setupTemperatureStackView()

        setupConstraints()
    }

    private func setupConstraints() {
        setupWeatherIconImageViewConstraints()
        setupEnglishWeekdayLabelConstraints()
        setupJapaneseWeekdayLabelConstraints()
        setupTemperatureStackViewConstraints()

    }

    public func update(dailyWeather: DailyWeather) {
        weatherIconImageView.image = UIImage(systemName: dailyWeather.conditionName)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        highTemperatureLabel.text = dailyWeather.maxTemperature.toCelcius
        lowTemperatureLabel.text = dailyWeather.minTemperature.toCelcius
        englishWeekdayLabel.text = dailyWeather.dayOfWeekEnglish
        japaneseWeekdayLabel.text = dailyWeather.dayOfWeekJapanese
    }

}

private extension ForecastCell {
    private func setupLowTemperatureLabel() {
        lowTemperatureLabel = UILabel().SystemFont10.LightGray
        lowTemperatureLabel.text = emptyTemperatureString
        lowTemperatureLabel.minimumScaleFactor = 0.5
    }

    private func setupHighTemperatureLabel() {
        highTemperatureLabel = UILabel().SystemFont10.White
        highTemperatureLabel.text = emptyTemperatureString
        highTemperatureLabel.minimumScaleFactor = 0.5
    }

    private func setupTemperatureStackView() {
        setupLowTemperatureLabel()

        setupHighTemperatureLabel()
        temperatureLabelStack = UIStackView(arrangedSubviews: [highTemperatureLabel, lowTemperatureLabel])
        temperatureLabelStack.autoresizesSubviews = true
        temperatureLabelStack.distribution = .fillEqually
        temperatureLabelStack.axis = .vertical
        temperatureLabelStack.alignment = .trailing
        temperatureLabelStack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(temperatureLabelStack)
    }

    private func setupTemperatureStackViewConstraints() {
        NSLayoutConstraint.activate([
            temperatureLabelStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            temperatureLabelStack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: distanceToCenter * ratio),
            temperatureLabelStack.heightAnchor.constraint(equalToConstant: 60 * ratio)
        ])
    }

    private func setupBackgroundImageView() {
        backgroundImageView = UIImageView(frame: frameSize)
        backgroundImageView.image = UIImage(named: backgroundImageName)
        backgroundImageView.layer.shadowRadius = 2
        backgroundImageView.layer.shadowOffset = .init(width: 0, height: 2)
        backgroundImageView.layer.shadowColor = UIColor(ciColor: .black).cgColor
        backgroundImageView.layer.shadowOpacity = 0.5
        backgroundImageView.clipsToBounds = false
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundView = UIView()
        backgroundView!.addSubview(backgroundImageView)
    }

    private func setupSelectedBackgroundImageView() {
        let selectedImageView = UIImageView(frame: frameSize)
        selectedImageView.image = UIImage(named: backgroundImageName)
        selectedImageView.layer.shadowRadius = 2
        selectedImageView.layer.shadowOffset = .init(width: 0, height: 2)
        selectedImageView.layer.shadowColor = UIColor(ciColor: .white).cgColor
        selectedImageView.layer.shadowOpacity = 0.5
        selectedImageView.clipsToBounds = false
        selectedImageView.contentMode = .scaleAspectFit
        selectedBackgroundView = UIView()
        selectedBackgroundView!.addSubview(selectedImageView)
    }

    private func setupWeatherIconImageView() {
        weatherIconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        weatherIconImageView.contentMode = .scaleAspectFill
        updateWeatherIcon(imageName: defaultIconName)
        weatherIconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(weatherIconImageView)
    }

    private func updateWeatherIcon(imageName: String) {
        let weatherSymbolImage = UIImage(systemName: imageName)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        weatherIconImageView.image = weatherSymbolImage
    }

    private func setupWeatherIconImageViewConstraints() {
        NSLayoutConstraint.activate([
            weatherIconImageView.widthAnchor.constraint(equalToConstant: ratio * 42),
            weatherIconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -ratio * distanceToCenter)
        ])
    }

    private func setupEnglishWeekdayLabel() {
        englishWeekdayLabel = UILabel().SystemFont8.White
        englishWeekdayLabel.text = defaultEngWeekdayString
        self.addSubview(englishWeekdayLabel)
    }

    private func setupEnglishWeekdayLabelConstraints() {
        englishWeekdayLabel.translatesAutoresizingMaskIntoConstraints = false
        englishWeekdayLabel.sizeToFit()
        NSLayoutConstraint.activate([
            englishWeekdayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            englishWeekdayLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setupJapaneseWeekdayLabel() {
        japaneseWeekdayLabel = UILabel().SystemFont8.White
        japaneseWeekdayLabel.numberOfLines = 0
        japaneseWeekdayLabel.text = defaultJapWeekdayString
        self.addSubview(japaneseWeekdayLabel)
    }

    private func setupJapaneseWeekdayLabelConstraints() {
        japaneseWeekdayLabel.translatesAutoresizingMaskIntoConstraints = false
        japaneseWeekdayLabel.sizeToFit()
        NSLayoutConstraint.activate([
            japaneseWeekdayLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: distanceToCenter * ratio),
            japaneseWeekdayLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
