//
//  WeatherOverviewInteractor.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//  
//

import Foundation

class WeatherOverviewInteractor: PresenterToInteractorWeatherOverviewProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterWeatherOverviewProtocol?
    var weatherEntityRepository: WeatherEntitiesRepositoryRefresh?

    func fetch() {
        weatherEntityRepository?.refresh()
    }

}
