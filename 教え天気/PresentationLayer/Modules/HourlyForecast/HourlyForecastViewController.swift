//
//  HourlyForecastViewController.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/29.
//  
//

import UIKit

class HourlyForecastViewController: UIViewController {
//    lazy var collectionView = ReusableCollectionView()
//    let dataSource = HourlyForecastDataSource()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
//
//        dataSource.config(data: defaultHourlyData.map {HourlyWeather(hourlyWeather: $0, timeZone: defaultTimeZone)})
        super.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterHourlyForecastProtocol?
    
}

extension HourlyForecastViewController: PresenterToViewHourlyForecastProtocol{
    // TODO: Implement View Output Methods
}
