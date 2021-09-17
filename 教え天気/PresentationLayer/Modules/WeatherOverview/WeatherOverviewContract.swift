//
//  WeatherOverviewContract.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//  
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewWeatherOverviewProtocol {
    func refresh(data location: String)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterWeatherOverviewProtocol {
    
    var view: PresenterToViewWeatherOverviewProtocol? { get set }
    var interactor: PresenterToInteractorWeatherOverviewProtocol? { get set }
    var router: PresenterToRouterWeatherOverviewProtocol? { get set }

    var subModules: [UIViewController]? { get set }
    func fetch()
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorWeatherOverviewProtocol {
    
    var presenter: InteractorToPresenterWeatherOverviewProtocol? { get set }
    var weatherEntityRepository: WeatherEntitiesRepositoryRefresh? { get set }

    func fetch()
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterWeatherOverviewProtocol {
    
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterWeatherOverviewProtocol {
    
}
