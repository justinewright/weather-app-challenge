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

extension UIView {
    func addDiamondMask(cornerRadius: CGFloat = 0, xOffset: CGFloat = 0, yOffset: CGFloat = 0) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.midX + xOffset, y: bounds.minY + cornerRadius + yOffset))
        path.addLine(to: CGPoint(x: bounds.maxX - cornerRadius + xOffset, y: bounds.midY + yOffset))
        path.addLine(to: CGPoint(x: bounds.midX + xOffset, y: bounds.maxY - cornerRadius + yOffset))
        path.addLine(to: CGPoint(x: bounds.minX + cornerRadius + xOffset, y: bounds.midY + yOffset))
        path.close()

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = cornerRadius * 2
        shapeLayer.lineJoin = .round
        shapeLayer.lineCap = .round

        layer.mask = shapeLayer
    }
}
//
//extension UIImageView {
//
//    func makeRounded() {
//
//        self.layer.borderWidth = 10
//        self.layer.borderColor = UIColor.black.cgColor
//        self.layer.cornerRadius = 75
//        self.layer.shadowColor = UIColor.systemPink.cgColor
//        self.layer.shadowRadius = 20
//        self.layer.backgroundColor = UIColor.systemPink.cgColor
//        self.layer.shadowOpacity =  1
//        self.layer.shadowOffset = CGSize(width: 0, height: 0)
//    }
//}
//
//extension UIImage {
//    func resizeImage(targetSize: CGSize) -> UIImage {
//        let size = self.size
//        let widthRatio  = targetSize.width  / size.width
//        let heightRatio = targetSize.height / size.height
//        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
//        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
//
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
//        self.draw(in: rect)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return newImage!
//      }
//}

struct IntegratedTodaysAverageWeatherView: UIViewRepresentable {

    func makeUIView(context: UIViewRepresentableContext<IntegratedTodaysAverageWeatherView>) -> TodaysAverageTemperatureView {
        return TodaysAverageTemperatureView()
    }

    func updateUIView(_ uiView: TodaysAverageTemperatureView, context: UIViewRepresentableContext<IntegratedTodaysAverageWeatherView>) {}

}

struct TodaysAverageWeatherViewS: View {

    var body: some View {
        IntegratedTodaysAverageWeatherView()
    }
}

struct TodaysAverageWeatherViewS_Previews: PreviewProvider {
    static var previews: some View {
        TodaysAverageWeatherViewS()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}

