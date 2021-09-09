//
//  PageListLocationViewModel.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/06.
//

import Foundation
import Combine
import CoreLocation

class PageListLocationViewModel {

    private var locationRepo = LocationRepo.shared

    @Published var cityDictionary: [String] = []

    private var cancellables: Set<AnyCancellable> = []

    init() {
        self.locationRepo.observeChanges()
            .map{ $0 }
            .assign(to: \.cityDictionary, on: self)
            .store(in: &cancellables)

    }
}
