//
//  WeatherOverviewViewController.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//  
//

import UIKit

class WeatherOverviewViewController: UIViewController {
    private var primaryViewController = UIViewController()
    private var locationHeaderViewController: UIViewController!
    private var currentWeatherViewController: UIViewController!
    private var fiveDayForecastViewController: UIViewController!

    // MARK: - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        presenter?.fetch()
    }

    var emptyView: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .blue
        return vc
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .black

//        locationHeaderViewController = LocationHeaderRouter.createModule()
//        currentWeatherViewController = CurrentWeatherRouter.createModule()
//        fiveDayForecastViewController = FiveDayForecastRouter.createModule()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties
    var presenter: ViewToPresenterWeatherOverviewProtocol?

    fileprivate func setupLocationHeaderView() {
        locationHeaderViewController = presenter?.subModules![WeatherOverViewSubModules.locationHeader.rawValue]
        addChild(locationHeaderViewController)
        self.view.addSubview(locationHeaderViewController.view)
        locationHeaderViewController.didMove(toParent: self)
    }

    fileprivate func setupCurrentWeatherView() {
        currentWeatherViewController = presenter?.subModules![WeatherOverViewSubModules.currentWeather.rawValue]
        addChild(currentWeatherViewController)
        self.view.addSubview(currentWeatherViewController.view)
        currentWeatherViewController.didMove(toParent: self)
    }

    fileprivate func setupFiveDayForecastView() {
        fiveDayForecastViewController = presenter?.subModules![WeatherOverViewSubModules.fiveDayForecast.rawValue]
        addChild(fiveDayForecastViewController)
        self.view.addSubview(fiveDayForecastViewController.view)
        fiveDayForecastViewController.didMove(toParent: self)
    }

    private func setupView() {
        setupLocationHeaderView()
        setupCurrentWeatherView()
        setupFiveDayForecastView()
        setupConstraints()
    }

    private func setupConstraints() {
        setupLocationHeaderViewConstraints()
        setupCurrentWeatherViewConstraints()
        setupForecastViewConstraints()
    }

    private func setupLocationHeaderViewConstraints() {
        let locationHeaderView = locationHeaderViewController.view!
        locationHeaderView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            locationHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            locationHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            locationHeaderView.heightAnchor.constraint(equalToConstant: 42),
            locationHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        ])
    }

    private func setupCurrentWeatherViewConstraints() {
        let currentWeatherView = currentWeatherViewController.view!
        currentWeatherView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentWeatherView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            currentWeatherView.topAnchor.constraint(equalTo: self.locationHeaderViewController.view.bottomAnchor, constant: 0),
            currentWeatherView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            currentWeatherView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height )
        ])
    }

    private func setupForecastViewConstraints() {
        let forecastView = fiveDayForecastViewController.view!
        forecastView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forecastView.heightAnchor.constraint(greaterThanOrEqualToConstant: 226),
            forecastView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40),
            forecastView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            forecastView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        ])
    }
    
}

extension WeatherOverviewViewController: PresenterToViewWeatherOverviewProtocol{
    func refresh(data location: String) {
        
    }

    // TODO: Implement View Output Methods
}
