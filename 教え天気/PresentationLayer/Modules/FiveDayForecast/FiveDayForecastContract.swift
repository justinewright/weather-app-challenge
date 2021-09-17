//
//  FiveDayForecastContract.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//  
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewFiveDayForecastProtocol {
    func refresh(data dailyForecast: [DailyWeather])
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterFiveDayForecastProtocol {
    
    var view: PresenterToViewFiveDayForecastProtocol? { get set }
    var interactor: PresenterToInteractorFiveDayForecastProtocol? { get set }
    var router: PresenterToRouterFiveDayForecastProtocol? { get set }

    var createCustomForecastCollectionView: ForecastCollectionView { get }
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorFiveDayForecastProtocol {
    
    var presenter: InteractorToPresenterFiveDayForecastProtocol? { get set }
    var forecastWeatherPublisher: WeatherEntitiesRepositoryDailyForecastWeatherPublisher? {get set}
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterFiveDayForecastProtocol {
    func updateFiveDayForecast(using dailyForecast: [DailyWeather])
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterFiveDayForecastProtocol {
    
}
