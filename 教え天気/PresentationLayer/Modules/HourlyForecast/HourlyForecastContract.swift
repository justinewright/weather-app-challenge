//
//  HourlyForecastContract.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/29.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewHourlyForecastProtocol {
    func show(theHourlyWeather hourlyWeather: [HourlyWeather])
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterHourlyForecastProtocol {
    
    var view: PresenterToViewHourlyForecastProtocol? { get set }
    var interactor: PresenterToInteractorHourlyForecastProtocol? { get set }
    var router: PresenterToRouterHourlyForecastProtocol? { get set }

    func updateView()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorHourlyForecastProtocol {
    
    var presenter: InteractorToPresenterHourlyForecastProtocol? { get set }

    func fetchCurrentWeather()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterHourlyForecastProtocol {
    func fetchedHourlyWeather(hourlyWeather: [HourlyWeather])
    func fetchedHourlyWeatherFailed(message: String)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterHourlyForecastProtocol {
    
}
