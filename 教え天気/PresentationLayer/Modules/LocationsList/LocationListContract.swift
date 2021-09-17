//
//  LocationListContract.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/16.
//  
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewLocationListProtocol {
    func refresh(locations: [String])
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterLocationListProtocol {
    
    var view: PresenterToViewLocationListProtocol? { get set }
    var interactor: PresenterToInteractorLocationListProtocol? { get set }
    var router: PresenterToRouterLocationListProtocol? { get set }
    func refresh()
    var addButton: UIButton { get }
    func addAddress(_ address: String)
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorLocationListProtocol {
    
    var presenter: InteractorToPresenterLocationListProtocol? { get set }
    func addAddress(_ address: String)
    func fetchAddresses()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterLocationListProtocol {
    func update(locationAddresses: [String])
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterLocationListProtocol {
    func locationSearcher(vc: LocationListViewController)
}
