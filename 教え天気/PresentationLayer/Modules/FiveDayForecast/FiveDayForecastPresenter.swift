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
    
}

extension FiveDayForecastPresenter: InteractorToPresenterFiveDayForecastProtocol {
    func updateFiveDayForecast(using dailyForecast: [DailyWeather]) {
        view?.refresh(data: dailyForecast)
    }
    
    var createCustomForecastCollectionView: ForecastCollectionView {
        ForecastCollectionView()
    }
}
