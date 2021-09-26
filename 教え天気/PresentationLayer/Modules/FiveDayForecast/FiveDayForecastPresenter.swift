//
//  FiveDayForecastPresenter.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//  
//

import Foundation

class FiveDayForecastPresenter: ViewToPresenterFiveDayForecastProtocol {

    // MARK: Properties
    var view: PresenterToViewFiveDayForecastProtocol?
    var interactor: PresenterToInteractorFiveDayForecastProtocol?
    var router: PresenterToRouterFiveDayForecastProtocol?

    func updateView() {
        interactor?.fetchForecast()
    }
}

extension FiveDayForecastPresenter: InteractorToPresenterFiveDayForecastProtocol {
    func fetchedForecast(dailyForecast: [DailyWeather]) {
        view?.showForecast(usingDailyForecast: dailyForecast)
    }

    func fetchedForecastFailed(message: String) {
        // something
    }
}
