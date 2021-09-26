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

    func updateView() {
        interactor?.fetchCurrentWeather()
    }
}

extension CurrentWeatherPresenter: InteractorToPresenterCurrentWeatherProtocol {
    func fetchedCurrentWeather(currentWeather: CurrentWeather) {
        view?.showCurrentWeather(withCurrentWeather: currentWeather)
    }

    func fetchedCurrentWeatherFailed(message: String) {
        
    }

}
