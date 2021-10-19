//
//  WeatherOverviewViewController.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//  
//

import UIKit

typealias WeatherOverviewSubmodules = (
    locationHeader: UIViewController,
    currentWeather: UIViewController,
    hourlyWeather: UIViewController,
    fiveDayForecast: UIViewController,
    detailsView: UIViewController
)

class WeatherOverviewViewController: UIViewController {
    private var submodules: WeatherOverviewSubmodules!
    // MARK: - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }

    // MARK: - Initialization
    init(usingSubmodules weatherOverviewSubmodules: WeatherOverviewSubmodules) {
        super.init(nibName: nil, bundle: nil)
        submodules = (
            locationHeader: weatherOverviewSubmodules.locationHeader,
            currentWeather: weatherOverviewSubmodules.currentWeather,
            hourlyWeather: weatherOverviewSubmodules.hourlyWeather,
            fiveDayForecast: weatherOverviewSubmodules.fiveDayForecast,
            detailsView: weatherOverviewSubmodules.detailsView
        )
        view.backgroundColor = .black
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties
    var presenter: ViewToPresenterWeatherOverviewProtocol?

    private func addSubmodule(_ submodule: UIViewController) {
        addChild(submodule)
        self.view.addSubview(submodule.view)
        submodule.didMove(toParent: self)
    }

    private func setupView() {
        addSubmodule(submodules.locationHeader)
        addSubmodule(submodules.currentWeather)
        addSubmodule(submodules.fiveDayForecast)

        setupConstraints()
        applyStyle()
    }

    private func setupConstraints() {
        setupLocationHeaderViewConstraints()
        setupCurrentWeatherViewConstraints()
        setupForecastViewConstraints()
    }

    private func setupLocationHeaderViewConstraints() {
        let locationHeaderView = submodules.locationHeader.view!
        locationHeaderView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            locationHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            locationHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            locationHeaderView.heightAnchor.constraint(equalToConstant: 42),
            locationHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        ])
    }

    private func setupCurrentWeatherViewConstraints() {
        let currentWeatherView = submodules.currentWeather.view!
        currentWeatherView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentWeatherView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            currentWeatherView.topAnchor.constraint(equalTo: self.submodules.locationHeader.view.bottomAnchor, constant: 0),
            currentWeatherView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            currentWeatherView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height )
        ])
    }

    private func setupForecastViewConstraints() {
        let forecastView = submodules.fiveDayForecast.view!
        forecastView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forecastView.heightAnchor.constraint(greaterThanOrEqualToConstant: 226),
            forecastView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40),
            forecastView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            forecastView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        ])
    }

    private func applyStyle() {
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
    }
    
}

extension WeatherOverviewViewController: PresenterToViewWeatherOverviewProtocol{
    // TODO: Implement View Output Methods
}
