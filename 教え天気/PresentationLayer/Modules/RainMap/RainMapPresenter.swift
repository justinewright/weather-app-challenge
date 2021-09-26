//
//  RainMapPresenter.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/26.
//  
//

import Foundation

class RainMapPresenter: ViewToPresenterRainMapProtocol {

    // MARK: Properties
    var view: PresenterToViewRainMapProtocol?
    var interactor: PresenterToInteractorRainMapProtocol?
    var router: PresenterToRouterRainMapProtocol?
}

extension RainMapPresenter: InteractorToPresenterRainMapProtocol {
    
}
