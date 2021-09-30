//
//  WeatherDetailsViewController.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/30.
//  
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterWeatherDetailsProtocol?
    
}

extension WeatherDetailsViewController: PresenterToViewWeatherDetailsProtocol{
    // TODO: Implement View Output Methods
}
