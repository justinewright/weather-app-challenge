//
//  ForecastCell.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/30.
//

import Foundation
import SwiftUI
import UIKit

class ForecastCell: UICollectionViewCell {
    static let width: CGFloat = 226.0
    private var weatherIconImageView = UIImageView()
    private var backgroundImageView: UIImageView!
    private var temperatureLabelStack: UIStackView!
    private var lowTemperatureLabel: SmallTurqoiseLabel!
    private var highTemperatureLabel: MediumWhiteLabel!

    private var englishWeekdayLabel: MediumWhiteLabel!
    private var japaneseWeekdayLabel: MediumWhiteLabel!

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

    public func setup(weatherModel: WeatherModel) {
        weatherIconImageView.image = UIImage(systemName: weatherModel.conditionName)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        highTemperatureLabel.text = weatherModel.maxTemperatureString
        lowTemperatureLabel.text = weatherModel.minTemperatureString
        englishWeekdayLabel.text = weatherModel.dayOfWeekEnglish
        japaneseWeekdayLabel.text = weatherModel.dayOfWeekJapanese
    }

}

private extension ForecastCell {
    private func setupLowTemperatureLabel() {
        lowTemperatureLabel = SmallTurqoiseLabel()
        lowTemperatureLabel.text = "5°C"
    }

    private func setupHighTemperatureLabel() {
        highTemperatureLabel = MediumWhiteLabel()
        highTemperatureLabel.text = "25°C"
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
        backgroundImageView = UIImageView(frame: CGRect (x: 0, y: 0, width: 226, height: 226))
        backgroundImageView.image = UIImage(named: "forecastCell")
        backgroundImageView.layer.shadowRadius = 2
        backgroundImageView.layer.shadowOffset = .init(width: 0, height: 5)
        backgroundImageView.layer.shadowColor = UIColor(.black).cgColor
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
        updateWeatherIcon(imageName: "sun.max")
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
        englishWeekdayLabel = MediumWhiteLabel()
        englishWeekdayLabel.text = "Mon"
        self.addSubview(englishWeekdayLabel)
    }

    private func setupEnglishWeekdayLabelConstraints() {
        NSLayoutConstraint.activate([
            englishWeekdayLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -60),
            englishWeekdayLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setupJapaneseWeekdayLabel() {
        japaneseWeekdayLabel = MediumWhiteLabel()
        japaneseWeekdayLabel.numberOfLines = 0
        japaneseWeekdayLabel.text = "月\r\n曜\r\n日"
        self.addSubview(japaneseWeekdayLabel)
    }

    private func setupJapaneseWeekdayLabelConstraints() {
        NSLayoutConstraint.activate([
            japaneseWeekdayLabel.centerXAnchor.constraint(equalTo: centerXAnchor,  constant: 60),
            japaneseWeekdayLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}


struct IntegratedForecastCellView: UIViewRepresentable {

    func makeUIView(context: UIViewRepresentableContext<IntegratedForecastCellView>) -> ForecastCell {
        return ForecastCell()
    }

    func updateUIView(_ uiView: ForecastCell, context: UIViewRepresentableContext<IntegratedForecastCellView>) {}

}

struct ForecastCellView: View {

    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 320 / 2)
                    .foregroundColor(.blue)
                    .frame(width: 226, height: 226, alignment: .center)
                    .overlay(IntegratedForecastCellView())

            }
        }
    }
}

struct ForecastCellView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastCellView()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
