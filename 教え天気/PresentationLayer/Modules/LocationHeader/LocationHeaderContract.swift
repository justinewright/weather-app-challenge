//
//  LocationHeaderContract.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//  
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewLocationHeaderProtocol {
    func refresh(data address: String)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterLocationHeaderProtocol {
    
    var view: PresenterToViewLocationHeaderProtocol? { get set }
    var interactor: PresenterToInteractorLocationHeaderProtocol? { get set }
    var router: PresenterToRouterLocationHeaderProtocol? { get set }

    var createHeaderLabel: UILabel { get }
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorLocationHeaderProtocol {
    
    var presenter: InteractorToPresenterLocationHeaderProtocol? { get set }
    var addressPublisher: WeatherEntitiesRepositoryAddressPublisher? {get set}
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterLocationHeaderProtocol {
    func updateLocation(withAddress address: String)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterLocationHeaderProtocol {
    
}
