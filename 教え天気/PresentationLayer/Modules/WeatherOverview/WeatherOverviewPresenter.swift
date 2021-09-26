//
//  WeatherOverviewPresenter.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//  
//

class WeatherOverviewPresenter: ViewToPresenterWeatherOverviewProtocol {
    
    // MARK: Properties
    var view: PresenterToViewWeatherOverviewProtocol?
    var interactor: PresenterToInteractorWeatherOverviewProtocol?
    var router: PresenterToRouterWeatherOverviewProtocol?

}

extension WeatherOverviewPresenter: InteractorToPresenterWeatherOverviewProtocol {

}
