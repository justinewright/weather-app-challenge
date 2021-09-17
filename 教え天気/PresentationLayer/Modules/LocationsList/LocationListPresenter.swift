//
//  LocationListPresenter.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/16.
//  
//

import UIKit

class LocationListPresenter: ViewToPresenterLocationListProtocol {

    // MARK: Properties
    var view: PresenterToViewLocationListProtocol?
    var interactor: PresenterToInteractorLocationListProtocol?
    var router: PresenterToRouterLocationListProtocol?

    func refresh() {
        interactor?.fetchAddresses()
    }

    lazy var addButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.tintColor = .black
        button.layer.cornerRadius = 20

        button.setTitle("+", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)

        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(addLocation), for: .touchUpInside)
        return button
    }()

    func addAddress(_ address: String) {
        interactor?.addAddress(address)
    }

    @objc func addLocation() {
        if let castedViewController = view as? LocationListViewController {
            router?.locationSearcher(vc: castedViewController)
        }
    }
}

extension LocationListPresenter: InteractorToPresenterLocationListProtocol {
    func update(locationAddresses: [String]) {
        view?.refresh(locations: locationAddresses)
    }
    
}
