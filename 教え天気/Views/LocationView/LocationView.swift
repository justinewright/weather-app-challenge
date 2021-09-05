//
//  LocationLabel.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/30.
//

import Foundation
import UIKit
import Combine

class LocationView: MediumWhiteLabel {
    private var locationLabel: MediumWhiteLabel!
    private var viewModel: LocationViewModel!
    private var cancellables: Set<AnyCancellable> = []

    required init(viewModel: LocationViewModel = LocationViewModel()) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        setupView()
        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        locationLabel = MediumWhiteLabel()
        self.textAlignment = .center
        self.backgroundColor = UIColor(named: "Light Turqoise")
        self.text = viewModel.cityName
        self.addSubview(locationLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: topAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            locationLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.$cityName
            .receive(on: DispatchQueue.main)
            .sink { self.text = $0 }
            .store(in: &cancellables)
    }
}
