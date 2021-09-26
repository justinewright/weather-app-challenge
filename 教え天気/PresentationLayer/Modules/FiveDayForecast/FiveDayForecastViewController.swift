//
//  FiveDayForecastViewController.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//  
//

import UIKit

class FiveDayForecastViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        setupView()
    }

    // MARK: - Initialization
    init() {
        super.init(nibName: nil, bundle: nil)
        forecastCollectionView = ForecastCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties
    var presenter: ViewToPresenterFiveDayForecastProtocol?
    private var forecastCollectionView: ForecastCollectionView!
    private var fiveDayDailyforecast: [DailyWeather]!

    private func setupView() {
        self.view.addSubview(forecastCollectionView)
        setupConstraints()
    }

    private func setupConstraints() {
        self.forecastCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forecastCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            forecastCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            forecastCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            forecastCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension FiveDayForecastViewController: PresenterToViewFiveDayForecastProtocol {
    func showForecast(usingDailyForecast dailyForecast: [DailyWeather]) {
        DispatchQueue.main.async {
            self.fiveDayDailyforecast = dailyForecast
            self.forecastCollectionView.refresh(data:   self.fiveDayDailyforecast)
        }
    }
    // TODO: Implement View Output Methods
}
