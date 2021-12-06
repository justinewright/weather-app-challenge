//
//  WeatherDetailsViewController.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/30.
//  
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    // MARK: - Properties
    var presenter: ViewToPresenterWeatherDetailsProtocol?
    private lazy var detailsView = DetailsWeatherView()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = detailsView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension WeatherDetailsViewController: PresenterToViewWeatherDetailsProtocol{
    // TODO: Implement View Output Methods
}

extension WeatherDetailsViewController: ForecastCollectionViewDelegate {
    func selectedCellInformation(_ dailyWeather: DailyWeather) {
        detailsView.configure(withDailyWeather: dailyWeather)
    }

}
