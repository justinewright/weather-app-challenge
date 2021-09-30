//
//  HourlyForecastPresenter.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/29.
//  
//

import Foundation

class HourlyForecastPresenter: ViewToPresenterHourlyForecastProtocol {

    // MARK: Properties
    var view: PresenterToViewHourlyForecastProtocol?
    var interactor: PresenterToInteractorHourlyForecastProtocol?
    var router: PresenterToRouterHourlyForecastProtocol?
}

extension HourlyForecastPresenter: InteractorToPresenterHourlyForecastProtocol {
    
}
