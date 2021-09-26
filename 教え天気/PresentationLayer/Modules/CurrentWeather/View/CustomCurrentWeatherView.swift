//
//  CustomHourlyWeatherView.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//

import UIKit
import Combine

class CustomCurrentWeatherView: UIView {

    private var backgroundImageView: UIImageView!
    private var temperatureLabel: UILabel!
    private var dateLabel: UILabel!
    private var verticalStack: UIStackView!
    private var backgroundWeatherImageView: UIImageView!
    private var characterImageView: UIImageView!

    private var cancellables: Set<AnyCancellable> = []

    required init() {
        super.init(frame: .zero)

        setupView()
    }

    func update(currentWeather: CurrentWeather) {
        temperatureLabel.text = currentWeather.temperature.toCelcius
        dateLabel.text = "\(Date().todaysWeekDay)\r\n\(Date().todayFormated)"
        backgroundWeatherImageView.image = UIImage(named: currentWeather.backgroundName)
        characterImageView.image = UIImage(named: "character")?.withTintColor(.white, renderingMode: .alwaysOriginal)
    }

    private func setupView() {
        self.frame = .zero
        setupBackgroundWeatherImageView()
        setupBackgroundCharacterImageView()
        setupBackgroundImageView()
        setupVerticalStack()

        setupConstraints()
    }

    private func setupConstraints() {
        setupBackgroundWeatherImageViewConstraints()
        setupBackgroundCharacterImageViewConstraints()
        setupVerticalStackConstraints()
        setupBackgroundImageViewConstraints()
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupBackgroundImageView() {
        backgroundImageView = UIImageView(frame: self.frame)
        backgroundImageView.image = UIImage(named: "avgTempCard")
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backgroundImageView)
    }

    private func setupVerticalStack() {
        setupTemperatureLabel()
        setupDateLabel()
        verticalStack = UIStackView(arrangedSubviews: [temperatureLabel, dateLabel])
        verticalStack.distribution = .equalCentering
        verticalStack.axis = .vertical
        verticalStack.alignment = .center
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(verticalStack)
    }

    private func setupBackgroundImageViewConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.85),
            backgroundImageView.widthAnchor.constraint(equalToConstant:UIScreen.main.bounds.width),
            backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        ])
    }

    private func setupVerticalStackConstraints() {
        NSLayoutConstraint.activate([
            verticalStack.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 0),
            verticalStack.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),
            verticalStack.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.85 / 2.5),
            verticalStack.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: UIScreen.main.bounds.width * 0.85/3)
        ])
    }

    private func setupBackgroundCharacterImageView() {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "character")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        characterImageView = imageView
        self.addSubview(characterImageView)
    }

    private func setupBackgroundCharacterImageViewConstraints() {
        NSLayoutConstraint.activate([
            characterImageView.centerXAnchor.constraint(equalTo: self.trailingAnchor, constant: -75),
            characterImageView.topAnchor.constraint(equalTo: self.backgroundImageView.bottomAnchor, constant: 20),
            characterImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2)
        ])
    }

    private func setupBackgroundWeatherImageView() {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: CurrentWeather(dailyWeather: defaultDailyData.first!, currentWeather: defaultCurrentData).backgroundName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundWeatherImageView = imageView
        self.addSubview(backgroundWeatherImageView)
    }

    private func setupBackgroundWeatherImageViewConstraints() {
        NSLayoutConstraint.activate([
            backgroundWeatherImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backgroundWeatherImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backgroundWeatherImageView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }

    private func setupTemperatureLabel() {
        temperatureLabel = UILabel()
        temperatureLabel.text = "__°C"
        temperatureLabel.textAlignment = .center
        temperatureLabel.textColor = .black
        temperatureLabel.font = .systemFont(ofSize: 60)
        temperatureLabel.sizeToFit()
    }

    private func setupDateLabel() {
        dateLabel = UILabel()
        dateLabel.textAlignment = .left
        dateLabel.numberOfLines = 0
        dateLabel.text = "Monday\r\n9/27"
        dateLabel.textColor = .gray
        dateLabel.font = .systemFont(ofSize: 18)
        temperatureLabel.sizeToFit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
