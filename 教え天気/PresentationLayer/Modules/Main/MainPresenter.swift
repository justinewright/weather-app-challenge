//
//  MainPresenter.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/16.
//  
//

import Foundation

class MainPresenter: ViewToPresenterMainProtocol {

    // MARK: Properties
    var view: PresenterToViewMainProtocol?
    var interactor: PresenterToInteractorMainProtocol?
    var router: PresenterToRouterMainProtocol?
}

extension MainPresenter: InteractorToPresenterMainProtocol {
}
