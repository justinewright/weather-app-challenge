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
    func showAddress(withAddress address: String)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterLocationHeaderProtocol {
    
    var view: PresenterToViewLocationHeaderProtocol? { get set }
    var interactor: PresenterToInteractorLocationHeaderProtocol? { get set }
    var router: PresenterToRouterLocationHeaderProtocol? { get set }
    func updateView()
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorLocationHeaderProtocol {
    var presenter: InteractorToPresenterLocationHeaderProtocol? { get set }
    func fetchAddress()
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterLocationHeaderProtocol {
    func addressFetched(address: String)
    func addressFetchedFailed(message: String)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterLocationHeaderProtocol {
    
}
