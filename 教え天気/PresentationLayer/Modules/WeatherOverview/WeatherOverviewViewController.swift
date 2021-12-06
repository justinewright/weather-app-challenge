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
    // MARK: - Properties
    var presenter: ViewToPresenterWeatherOverviewProtocol?
    private var submodules: WeatherOverviewSubmodules!
    private var vStack: UIStackView!

    // MARK: - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
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

    private func setupView() {
        initVerticalStackView(views: [BaseView(titleText: "現\r\n在",
                                               content: submodules.currentWeather.view),
                                      BaseView(titleText: "一\r\n時\r\n間\r\nご\r\nと",
                                               content: submodules.hourlyWeather.view),
                                      BaseView(titleText: "五\r\n日\r\n間",
                                               content: submodules.fiveDayForecast.view),
                                      BaseView(titleText: "詳\r\n細",
                                               content: submodules.detailsView.view)])
        setupConstraints()

        submodules.currentWeather.view.makeMediumView(anchorTo: view)
        submodules.hourlyWeather.view.makeMediumView(anchorTo: view)
        submodules.fiveDayForecast.view.makeMediumView(anchorTo: view)
        submodules.detailsView.view.makeLargeView(anchorTo: view)

        view.addSubview(submodules.locationHeader.view)
        addChild(submodules.locationHeader)
        submodules.locationHeader.willMove(toParent: self)
        setupLocationHeaderViewConstraints()
        
        applyStyle()
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

    private func setupConstraints() {
        let bottomAnchorr = vStack.arrangedSubviews.isEmpty ? view.topAnchor : vStack.arrangedSubviews.last?.bottomAnchor
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        vStack.bottomAnchor.constraint(equalTo: bottomAnchorr!).isActive = true
        vStack.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
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

    private func applyStyle() {
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
    }
    
}

extension WeatherOverviewViewController: PresenterToViewWeatherOverviewProtocol{
    // TODO: Implement View Output Methods
}
