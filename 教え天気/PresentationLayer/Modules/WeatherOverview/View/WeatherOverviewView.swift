//
//  LocationsWeatherOverviewView.swift
//  教え天気
//
//  Created by Justine Wright on 2021/10/19.
//

import UIKit

typealias WeatherOverviewSubmodulesViews = (
    locationHeader: UIView,
    currentWeather: UIView,
    hourlyWeather: UIView,
    fiveDayForecast: UIView,
    detailsView: UIView
)

class WeatherOverviewView: UIViewController {
    private var submodules: WeatherOverviewSubmodules!
    private var vStack: UIStackView!

    init(usingSubmoduleViews weatherSubmodules: WeatherOverviewSubmodulesViews) {
        super.init(nibName: nil, bundle: nil)
        let location = weatherSubmodules.locationHeader
        let current = weatherSubmodules.currentWeather
        let hourly = weatherSubmodules.hourlyWeather
        let forecast = weatherSubmodules.fiveDayForecast
        let details = weatherSubmodules.detailsView
        initVerticalStackView(views: [location, current, hourly, forecast, details])
        setupSubmoduleConstraints(current, forecast, hourly, details)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupStackConstraints()
    }

    private func initVerticalStackView(views: [UIView]) {
        vStack = UIStackView(arrangedSubviews: views)
        vStack.axis = .vertical
        vStack.distribution = .fill
        vStack.spacing = 10
        vStack.alignment = .center
        vStack.isLayoutMarginsRelativeArrangement = true
        vStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom:0, trailing: 0)
        vStack.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.addSubview(vStack)
    }

    private func setupStackConstraints() {
        let bottomAnchorr = vStack.arrangedSubviews.isEmpty ? view.topAnchor : vStack.arrangedSubviews.last?.bottomAnchor
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        vStack.bottomAnchor.constraint(equalTo: bottomAnchorr!).isActive = true
        vStack.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }

    fileprivate func setupSubmoduleConstraints(_ current: UIView, _ forecast: UIView, _ hourly: UIView, _ details: UIView) {
        current.translatesAutoresizingMaskIntoConstraints = false
        forecast.translatesAutoresizingMaskIntoConstraints = false
        hourly.translatesAutoresizingMaskIntoConstraints = false
        details.translatesAutoresizingMaskIntoConstraints = false
        current.makeLargeView(anchorTo: view)
        hourly.makeMediumView(anchorTo: view)
        forecast.makeMediumView(anchorTo: view)
        details.makeLargeView(anchorTo: view)
    }

}
