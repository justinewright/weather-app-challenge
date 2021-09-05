//
//  LocationViewModel.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/02.
//

import Foundation
import Combine

class LocationViewModel {
    private var repository: Repository

    @Published var cityName: String = "Unavailable"

    private var cancellables: Set<AnyCancellable> = []

    init(repository: Repository = Repository()) {
        self.repository = repository
        self.repository.city
            .receive(on: DispatchQueue.main)
            .sink { self.cityName = $0 }
            .store(in: &cancellables)
    }
}

