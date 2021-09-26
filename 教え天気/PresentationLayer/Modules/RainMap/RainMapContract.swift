//
//  RainMapContract.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/26.
//  
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewRainMapProtocol {
   
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterRainMapProtocol {
    
    var view: PresenterToViewRainMapProtocol? { get set }
    var interactor: PresenterToInteractorRainMapProtocol? { get set }
    var router: PresenterToRouterRainMapProtocol? { get set }
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorRainMapProtocol {
    
    var presenter: InteractorToPresenterRainMapProtocol? { get set }
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterRainMapProtocol {
    
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterRainMapProtocol {
    
}
