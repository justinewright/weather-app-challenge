//
//  TodaysAverageWeather.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/30.
//

import Foundation

import UIKit
import SwiftUI
import Combine

class TodaysAverageTemperatureView: UIView {

    private var todaysWeather = WeatherModel.default
    private var backgroundImageView: UIImageView!
    private var temperatureLabel: UILabel!
    private var dateLabel: UILabel!
    private var verticalStack: UIStackView!

    private var viewModel: TodaysAverageTemperatureViewModel!
    private var cancellables: Set<AnyCancellable> = []

    required init(viewModel: TodaysAverageTemperatureViewModel = TodaysAverageTemperatureViewModel()) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        setupView()
        setupBindings()
    }

    private func update(weatherModel: WeatherModel){
        temperatureLabel.text = weatherModel.temperatureString
        dateLabel.text = "\(Date().todaysWeekDay())\r\n\(Date().todayFormated())"
    }

    private func setupView() {
        self.frame = .zero
        setupBackgroundImageView()
        setupVerticalStack()

        setupConstraints()
    }

    private func setupConstraints() {
        setupVerticalStackConstraints()
        setupBackgroundImageViewConstraints()
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupBindings() {
        viewModel.$todaysWeather
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { vm in
                self.update(weatherModel: vm)
            }
            .store(in: &cancellables)
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

    private func setupBackgroundImageViewConstraints(){
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

    private func setupTemperatureLabel() {
        temperatureLabel = UILabel()
        temperatureLabel.text = todaysWeather.temperatureString
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
