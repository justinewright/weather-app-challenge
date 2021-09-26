//
//  ForecastCell.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//

import Foundation
import UIKit

class ForecastCell: UICollectionViewCell {
    static let width: CGFloat = 226.0
    private var weatherIconImageView = UIImageView()
    private var backgroundImageView: UIImageView!
    private var temperatureLabelStack: UIStackView!
    private var lowTemperatureLabel: UILabel!
    private var highTemperatureLabel: UILabel!

    private var englishWeekdayLabel: UILabel!
    private var japaneseWeekdayLabel: UILabel!
    private var frameSize: CGRect = CGRect(x: 0, y: 0, width: 226, height: 226)
    private var backgroundImageName = "forecastCell"
    private var emptyTemperatureString = "__°C"
    private var defaultIconName = "wifi.slash"
    private var defaultEngWeekdayString = "-"
    private var defaultJapWeekdayString = "-\r\n曜\r\n日"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }

    private func setupView() {
        setupBackgroundImageView()
        setupWeatherIconImageView()
        setupEnglishWeekdayLabel()
        setupJapaneseWeekdayLabel()
        setupTemperatureStackView()

        setupConstraints()
    }

    private func setupConstraints() {
        setupBackgroundImageViewConstraints()
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
        lowTemperatureLabel = UILabel().SystemFont12.LightGray
        lowTemperatureLabel.text = emptyTemperatureString
    }

    private func setupHighTemperatureLabel() {
        highTemperatureLabel = UILabel().SystemFont18.White
        highTemperatureLabel.text = emptyTemperatureString
    }

    private func setupTemperatureStackView() {
        setupLowTemperatureLabel()
        setupHighTemperatureLabel()
        temperatureLabelStack = UIStackView(arrangedSubviews: [highTemperatureLabel, lowTemperatureLabel])
        temperatureLabelStack.distribution = .equalCentering
        temperatureLabelStack.axis = .vertical
        temperatureLabelStack.alignment = .trailing
        temperatureLabelStack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(temperatureLabelStack)
    }

    private func setupTemperatureStackViewConstraints() {
        NSLayoutConstraint.activate([
            temperatureLabelStack.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            temperatureLabelStack.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor, constant: 60),
            temperatureLabelStack.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupBackgroundImageView() {
        backgroundImageView = UIImageView(frame: frameSize)
        backgroundImageView.image = UIImage(named: backgroundImageName)
        backgroundImageView.layer.shadowRadius = 2
        backgroundImageView.layer.shadowOffset = .init(width: 0, height: 5)
        backgroundImageView.layer.shadowColor = UIColor(ciColor: .black).cgColor
        backgroundImageView.layer.shadowOpacity = 0.5
        backgroundImageView.clipsToBounds = false
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backgroundImageView)
    }

    private func setupBackgroundImageViewConstraints(){
        NSLayoutConstraint.activate([
            backgroundImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 226),
            backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        ])
    }

    private func setupWeatherIconImageView() {
        weatherIconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 42, height: 42))
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
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 42),
            weatherIconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -60)
        ])
    }

    private func setupEnglishWeekdayLabel() {
        englishWeekdayLabel = UILabel().SystemFont18.White
        englishWeekdayLabel.text = defaultEngWeekdayString
        self.addSubview(englishWeekdayLabel)
    }

    private func setupEnglishWeekdayLabelConstraints() {
        englishWeekdayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            englishWeekdayLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -60),
            englishWeekdayLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setupJapaneseWeekdayLabel() {
        japaneseWeekdayLabel = UILabel().SystemFont18.White
        japaneseWeekdayLabel.numberOfLines = 0
        japaneseWeekdayLabel.text = defaultJapWeekdayString
        self.addSubview(japaneseWeekdayLabel)
    }

    private func setupJapaneseWeekdayLabelConstraints() {
        japaneseWeekdayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            japaneseWeekdayLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 60),
            japaneseWeekdayLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
