//
//  WeatherDetailsContract.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/30.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewWeatherDetailsProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterWeatherDetailsProtocol {
    
    var view: PresenterToViewWeatherDetailsProtocol? { get set }
    var interactor: PresenterToInteractorWeatherDetailsProtocol? { get set }
    var router: PresenterToRouterWeatherDetailsProtocol? { get set }
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorWeatherDetailsProtocol {
    
    var presenter: InteractorToPresenterWeatherDetailsProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterWeatherDetailsProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterWeatherDetailsProtocol {
    
}
