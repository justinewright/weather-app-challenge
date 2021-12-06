//
//  CurrentWeatherView.swift
//  教え天気
//
//  Created by Justine Wright on 2021/10/19.
//

import UIKit

final class CurrentWeatherView: UIView {
    // MARK: - Properties
    private var characterMask: UIImageView!
    private var characterBackgroundImageView: UIImageView!
    private var descriptionLabel: UILabel!
    private var currentTemperatureLabel: UILabel!
    private var highTemperatureLabel: UILabel!
    private var lowTemperatureLabel: UILabel!
    private var lineView: UIView!

    init() {
        super.init(frame: .zero)

        setupView()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(currentWeather: CurrentWeather) {
        highTemperatureLabel.text = currentWeather.maxTemperature.toCelcius
        lowTemperatureLabel.text = currentWeather.minTemperature.toCelcius
        currentTemperatureLabel.text = currentWeather.temperature.toCelcius
        descriptionLabel.text = currentWeather.descriptionString
        updateImageView(withImage: currentWeather.backgroundName)
    }
    // MARK: - Views

    private func setupView() {
        setupImageView()
        setupDescriptionLabel()
        setupCurrentTemperatureLabel()
        setupHighTemperatureLabel()
        setupLowTemperatureLabel()
        setupLine()
        setupConstraints()
    }

    private func updateImageView(withImage imageName: String = "rain") {
        let image = UIImage(named: imageName) ?? UIImage(named: "rain")!
        let mask = UIImage(named: "character")!
        let size = image.size

        let renderer = UIGraphicsImageRenderer(size: size)
        let newImage = renderer.image { context in
            image.draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: 1)
            mask.draw(in: CGRect(origin: .zero, size: size), blendMode: .lighten, alpha: 0.2)
            mask.draw(in: CGRect(origin: .zero, size: size), blendMode: .destinationIn, alpha: 1)
        }
        characterMask = UIImageView(image: newImage)
    }

    private func setupImageView() {
        updateImageView()
        characterMask.contentMode = .scaleAspectFit
        addSubview(characterMask)
    }

    private func setupDescriptionLabel() {
        descriptionLabel = UILabel().LightGray.SystemFont10
        descriptionLabel.text = "Description Text..."
        descriptionLabel.textAlignment = .right
        addSubview(descriptionLabel)
    }

    private func setupCurrentTemperatureLabel() {
        currentTemperatureLabel = UILabel().SystemFont24.t1
        currentTemperatureLabel.text = "25°C"
        currentTemperatureLabel.textAlignment = .right
        addSubview(currentTemperatureLabel)
    }

    private func setupHighTemperatureLabel() {
        highTemperatureLabel = UILabel().LightGray.SystemFont12
        highTemperatureLabel.text = "H: 30°C"
        highTemperatureLabel.textAlignment = .left
        addSubview(highTemperatureLabel)
    }

    private func setupLowTemperatureLabel() {
        lowTemperatureLabel = UILabel().LightGray.SystemFont12
        lowTemperatureLabel.text = "L: 5°C"
        lowTemperatureLabel.textAlignment = .left
        addSubview(lowTemperatureLabel)
    }

    private func setupLine() {
        lineView = UIView(frame: CGRect(x: 0, y: frame.height - 3, width: frame.width * 0.6, height: 3.0))
        lineView.backgroundColor = .white
        addSubview(lineView)
    }

    // MARK: - Constraints

    private func setupConstraints() {
        setupImageViewConstraints()
        setupDescriptionLabelConstraints()
        setupCurrentTemperatureLabelConstraints()
        setupHighTemperatureLabelConstraints()
        setupLowTemperatureLabelConstraints()
        setupLineConstraints()
    }

    private func setupImageViewConstraints() {

        characterMask.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            characterMask.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            characterMask.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            characterMask.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setupDescriptionLabelConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.trailingAnchor.constraint(equalTo: currentTemperatureLabel.leadingAnchor, constant: -5),
            descriptionLabel.bottomAnchor.constraint(equalTo: lineView.topAnchor, constant: -5),
            descriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: lineView.leadingAnchor)
        ])
    }

    private func setupCurrentTemperatureLabelConstraints() {
        currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTemperatureLabel.sizeToFit()
        NSLayoutConstraint.activate([
            currentTemperatureLabel.trailingAnchor.constraint(equalTo: lineView.trailingAnchor),
            currentTemperatureLabel.bottomAnchor.constraint(equalTo: lineView.topAnchor, constant: 0)

        ])
    }

    private func setupHighTemperatureLabelConstraints() {
        highTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        highTemperatureLabel.sizeToFit()
        NSLayoutConstraint.activate([
            highTemperatureLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            highTemperatureLabel.centerXAnchor.constraint(equalTo: currentTemperatureLabel.centerXAnchor, constant: 0)

        ])
    }

    private func setupLowTemperatureLabelConstraints() {
        lowTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        lowTemperatureLabel.sizeToFit()
        NSLayoutConstraint.activate([
            lowTemperatureLabel.topAnchor.constraint(equalTo: highTemperatureLabel.bottomAnchor),
            lowTemperatureLabel.trailingAnchor.constraint(equalTo: highTemperatureLabel.trailingAnchor, constant: 0)

        ])
    }

    private func setupLineConstraints() {
        lineView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lineView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

    }
}
