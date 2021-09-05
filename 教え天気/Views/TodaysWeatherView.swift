//
//  TodaysWeatherView.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/27.
//

import UIKit
import SwiftUI

class TodaysWeatherView: UIView {
    private var temperatureLabel: UILabel!
    private var dateLabel: UILabel!
    private var todaysWeather = WeatherModel.default
    private var image: TodaysWeatherImage!

    private var verticalStack: UIStackView!
    private var horizontalStack: UIStackView!

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.frame = CGRect(x: 0, y: 0, width: 400, height: 200)

        configureVerticalStack()
        configureHorizontalStack()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureVerticalStack() {
        configureTemperatureLabel()
        configureDateLabel()
        verticalStack = UIStackView(arrangedSubviews: [temperatureLabel, dateLabel])
        verticalStack.axis = .vertical
        verticalStack.alignment = .center
    }

    private func configureHorizontalStack() {
        image = TodaysWeatherImage()

        horizontalStack = UIStackView(arrangedSubviews: [verticalStack, image])
        horizontalStack.spacing = 10
        horizontalStack.distribution = .fillEqually
        horizontalStack.alignment = .center
        horizontalStack.axis = .horizontal
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(horizontalStack)
        horizontalStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        horizontalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        horizontalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

    private func configureTemperatureLabel() {
        temperatureLabel = UILabel()
        temperatureLabel.text = todaysWeather.temperatureString
        temperatureLabel.textAlignment = .center
        temperatureLabel.textColor = .white
        temperatureLabel.font = .systemFont(ofSize: 60, weight: UIFont.Weight(22))
        temperatureLabel.sizeToFit()
    }

    private func configureDateLabel() {
        dateLabel = UILabel()
        dateLabel.textAlignment = .center
        dateLabel.numberOfLines = 0
        dateLabel.text = """
            Monday
            9/27
        """
        dateLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 18)
        temperatureLabel.sizeToFit()
    }
}

struct IntegratedTodaysWeatherView: UIViewRepresentable {

    func makeUIView(context: UIViewRepresentableContext<IntegratedTodaysWeatherView>) -> TodaysWeatherView {
        return TodaysWeatherView()
    }

    func updateUIView(_ uiView: TodaysWeatherView, context: UIViewRepresentableContext<IntegratedTodaysWeatherView>) {}

}

struct HeaderCellView: View {

    var body: some View {
        IntegratedTodaysWeatherView()
    }
}

struct HeaderCellView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderCellView()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
