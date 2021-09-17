//
//  LocationHeaderPresenter.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//  
//

import Foundation
import UIKit

class LocationHeaderPresenter: ViewToPresenterLocationHeaderProtocol {

    // MARK: Properties
    var view: PresenterToViewLocationHeaderProtocol?
    var interactor: PresenterToInteractorLocationHeaderProtocol?
    var router: PresenterToRouterLocationHeaderProtocol?

}

extension LocationHeaderPresenter: InteractorToPresenterLocationHeaderProtocol {
    func updateLocation(withAddress address: String) {
        view?.refresh(data: address)
    }

    var createHeaderLabel: UILabel {
        let headerLabel = UILabel().White.SystemFont18
        headerLabel.textAlignment = .center
        headerLabel.backgroundColor = UIColor(named: "Light Turqoise")
        headerLabel.text = ""
        return headerLabel
    }

}
