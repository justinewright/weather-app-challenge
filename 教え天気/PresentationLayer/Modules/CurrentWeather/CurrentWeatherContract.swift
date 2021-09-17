//
//  HourlyWeatherContract.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//  
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewCurrentWeatherProtocol {
    func refresh(data currentWeather: CurrentWeather)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterCurrentWeatherProtocol {
    
    var view: PresenterToViewCurrentWeatherProtocol? { get set }
    var interactor: PresenterToInteractotCurrentWeatherProtocol? { get set }
    var router: PresenterToRouterCurrentWeatherProtocol? { get set }
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractotCurrentWeatherProtocol {
    
    var presenter: InteractorToPresenterCurrentWeatherProtocol? { get set }
    var currentWeatherPublisher: WeatherEntitiesRepositoryCurrentWeatherPublisher? {get set}
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterCurrentWeatherProtocol {
    func updateCurrentWeather(using currentWeather: CurrentWeather)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterCurrentWeatherProtocol {
    
}
