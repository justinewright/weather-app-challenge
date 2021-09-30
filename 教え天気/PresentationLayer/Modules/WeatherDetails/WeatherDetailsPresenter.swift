//
//  WeatherDetailsPresenter.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/30.
//  
//

import Foundation

class WeatherDetailsPresenter: ViewToPresenterWeatherDetailsProtocol {

    // MARK: Properties
    var view: PresenterToViewWeatherDetailsProtocol?
    var interactor: PresenterToInteractorWeatherDetailsProtocol?
    var router: PresenterToRouterWeatherDetailsProtocol?
}

extension WeatherDetailsPresenter: InteractorToPresenterWeatherDetailsProtocol {
    
}
