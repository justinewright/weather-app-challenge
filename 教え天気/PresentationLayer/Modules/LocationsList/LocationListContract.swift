//
//  LocationListContract.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/16.
//  
//
import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewLocationListProtocol {
    func showLocations(withAddresses address: [String])
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterLocationListProtocol {
    
    var view: PresenterToViewLocationListProtocol? { get set }
    var interactor: PresenterToInteractorLocationListProtocol? { get set }
    var router: PresenterToRouterLocationListProtocol? { get set }

    func updateView()
    func addLocationButtonPressed()
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorLocationListProtocol {
    
    var presenter: InteractorToPresenterLocationListProtocol? { get set }
    func addAddress(_ address: String)
    func fetchAddresses()
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterLocationListProtocol {
    func fetchedAddresses(locationAddresses: [String])
    func fetchedAddressesFailed(message: String)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterLocationListProtocol {
    func presentLocationSearcher(rootView: PresenterToViewLocationListProtocol, completion:@escaping (String) -> Void)
}
