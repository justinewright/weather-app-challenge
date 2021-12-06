//
//  HourlyForecastViewController.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/29.
//  
//

import UIKit

class HourlyForecastViewController: UIViewController {
    // MARK: - Properties
    private var hourlyWeatherView: HourlyWeatherView!
    var presenter: ViewToPresenterHourlyForecastProtocol?

    init() {
        super.init(nibName: nil, bundle: nil)
        hourlyWeatherView = HourlyWeatherView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        self.view = hourlyWeatherView
        setupConstraints()
    }

    private func setupConstraints() {
        self.hourlyWeatherView.translatesAutoresizingMaskIntoConstraints = false
        hourlyWeatherView.edgeTo(view: self.view)

    }
}

extension HourlyForecastViewController: PresenterToViewHourlyForecastProtocol{
    func show(theHourlyWeather hourlyWeather: [HourlyWeather]) {
        self.hourlyWeatherView.update(withHourlyWeather: hourlyWeather)
    }

    // TODO: Implement View Output Methods
}
