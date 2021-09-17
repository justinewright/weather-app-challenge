//
//  HourlyWeatherPresenter.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//  
//

import Foundation

class CurrentWeatherPresenter: ViewToPresenterCurrentWeatherProtocol {

    // MARK: Properties
    var view: PresenterToViewCurrentWeatherProtocol?
    var interactor: PresenterToInteractotCurrentWeatherProtocol?
    var router: PresenterToRouterCurrentWeatherProtocol?

}

extension CurrentWeatherPresenter: InteractorToPresenterCurrentWeatherProtocol {
    func updateCurrentWeather(using currentWeather: CurrentWeather) {
        view?.refresh(data: currentWeather)
    }
}
