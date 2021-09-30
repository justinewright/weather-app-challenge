//
//  HourlyCell.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/29.
//

import UIKit

class HourlyCell: UICollectionViewCell, Reusable {
    private var hourLabel: UILabel!
    private var temperatureLabel: UILabel!
    private  var iconImageView: UIImageView!

    static let flexibleWidth: CGFloat = UIScreen.main.bounds.height * 0.10 / 2
    static let flexibleHeight: CGFloat = UIScreen.main.bounds.height * 0.10
    let frameSize: CGRect = CGRect(x: 0, y: 0, width:  HourlyCell.flexibleWidth, height: HourlyCell.flexibleHeight)
    private var defaultIconName = "wifi.slash"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }

    public func setup(hourlyWeather: HourlyWeather) {
        hourLabel.text = hourlyWeather.hour
        temperatureLabel.text = hourlyWeather.temperature.toCelcius
        updateWeatherIcon(imageName: hourlyWeather.conditionName)
    }

    private func updateWeatherIcon(imageName: String) {
        let weatherSymbolImage = UIImage(systemName: imageName)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        iconImageView.image = weatherSymbolImage
    }

    private func setupView() {
        setupBackgroundView()
        setupHourLabel()
        setupTemperatureLabel()
        setupIconImageView()

        setupConstraints()
    }

    private func setupBackgroundView() {
        let backgroundImageView = UIView(frame: frameSize)
        backgroundImageView.frame = CGRect(x: backgroundImageView.frame.width / 2 - backgroundImageView.frame.height / 4,
                                           y: backgroundImageView.frame.height / 2 - backgroundImageView.frame.height / 4 ,
                                           width: frameSize.width,
                                           height: frameSize.width)
        backgroundImageView.createDiamondView()
        backgroundView = UIView(frame: frameSize)
        backgroundView!.addSubview(backgroundImageView)
    }

    private func setupHourLabel() {
        hourLabel = UILabel().SystemFont8.LightGray
        hourLabel.text = "__:__"
        hourLabel.textAlignment = .center
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(hourLabel)
    }

    private func setupTemperatureLabel() {
        temperatureLabel = UILabel().SystemFont12.LightGray
        temperatureLabel.text = "__°C"
        temperatureLabel.textAlignment = .center
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(temperatureLabel)
    }

    private func setupIconImageView() {
        iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        iconImageView.contentMode = .scaleAspectFill
        let weatherSymbolImage = UIImage(systemName: defaultIconName)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        iconImageView.image = weatherSymbolImage

        self.contentView.addSubview(iconImageView)
    }

    private func setupConstraints() {
        setupHourLabelConstraints()
        setupTemperatureLabelConstraints()
        setupIconImageViewConstraints()
    }

    private func setupHourLabelConstraints() {
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hourLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            hourLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    private func setupTemperatureLabelConstraints() {
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            temperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }

    private func setupIconImageViewConstraints() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: HourlyCell.flexibleWidth / 4 )
        ])
    }
}

extension UIView {
    func createDiamondView(cornerRadius: CGFloat = 0) {
        let path = UIBezierPath()

        let points = [
            CGPoint(x: bounds.midX, y: bounds.minX ),
            CGPoint(x: bounds.maxX, y: bounds.midX ),
            CGPoint(x: bounds.midX, y: bounds.maxX ),
            CGPoint(x: bounds.minX, y: bounds.midX )
        ]

        path.move(to: point(from: points[0], to: points[1], distance: cornerRadius, fromStart: true))
        for i in 0 ..< 4 {
            path.addLine(to: point(from: points[i], to: points[(i + 1) % 4], distance: cornerRadius, fromStart: false))
            path.addQuadCurve(to: point(from: points[(i + 1) % 4], to: points[(i + 2) % 4], distance: cornerRadius, fromStart: true), controlPoint: points[(i + 1) % 4])
        }
        path.close()

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = #colorLiteral(red: 0.09037123196, green: 0.4258021559, blue: 0.4316449479, alpha: 1)
        shapeLayer.strokeColor = UIColor.black.cgColor

        layer.addSublayer(shapeLayer)
    }

        private func point(from point1: CGPoint, to point2: CGPoint, distance: CGFloat, fromStart: Bool) -> CGPoint {
            let start: CGPoint
            let end: CGPoint

            if fromStart {
                start = point1
                end = point2
            } else {
                start = point2
                end = point1
            }
            let angle = atan2(end.y - start.y, end.x - start.x)
            return CGPoint(x: start.x + distance * cos(angle), y: start.y + distance * sin(angle))
        }

}
