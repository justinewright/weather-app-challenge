//
//  MainView.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/30.
//

import Foundation
import UIKit
import Combine

class MainView: UIView {

    private var viewModel = MainViewModel()
    private var backgroundImageView: UIImageView!
    private var backgroundCharacterImageView: UIImageView!
    private var locationView: LocationView!
    private var todaysAverageTemperatureView: TodaysAverageTemperatureView!
    private var forecastCollectionView: ForecastCollectionView!
    private var footerLabel: SmallWhiteLabel!

    private var footerText = "Daily"

    private var cancellables: Set<AnyCancellable> = []

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        setupBackgroundImageView()
        setupBackgroundCharacterImageView()
        locationView = LocationView(viewModel: viewModel.locationViewModel)
        todaysAverageTemperatureView = TodaysAverageTemperatureView(viewModel: viewModel.todaysAverageTemperatureViewModel)
        forecastCollectionView = ForecastCollectionView(viewModel: viewModel.forecastCollectionViewModel)
        setupFooterLabel()

        self.addSubview(footerLabel)
        self.addSubview(forecastCollectionView)
        self.addSubview(todaysAverageTemperatureView)
        self.addSubview(locationView)

        setupConstraints()
    }

    private func setupConstraints() {
        setupBackgroundImageViewConstraints()
        setupBackgroundCharacterImageViewConstraints()
        setupFooterLabelConstraints()
        setupLocationViewConstraints()
        setupTodaysAverageTemperatureViewConstraints()
        setupForecastCollectionViewConstraints()
    }

    private func setupBindings() {
        viewModel.$backgroundImage
            .receive(on: DispatchQueue.main)
            .sink { imageName in
                self.backgroundImageView.image = UIImage(named: imageName)!
            }
            .store(in: &cancellables)
    }

    fileprivate func setupFooterLabel() {
        footerLabel = SmallWhiteLabel()
        footerLabel.text = footerText
        footerLabel.textAlignment = .left
    }

    private func setupBackgroundImageView() {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView = imageView
        self.addSubview(backgroundImageView)
    }

    private func setupBackgroundImageViewConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }

    private func setupBackgroundCharacterImageView() {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "character")
        backgroundCharacterImageView = imageView
        self.addSubview(backgroundCharacterImageView)
    }

    private func setupBackgroundCharacterImageViewConstraints() {
        NSLayoutConstraint.activate([
            backgroundCharacterImageView.centerXAnchor.constraint(equalTo: self.trailingAnchor, constant: -100),
            backgroundCharacterImageView.bottomAnchor.constraint(equalTo: forecastCollectionView.bottomAnchor, constant: -270 / 3),
            backgroundCharacterImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3)
        ])
    }

    private func setupFooterLabelConstraints() {
        NSLayoutConstraint.activate([
            footerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            footerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            footerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            footerLabel.heightAnchor.constraint(equalToConstant: 42)
        ])
    }

    private func setupLocationViewConstraints() {
        NSLayoutConstraint.activate([
            locationView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            locationView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            locationView.heightAnchor.constraint(equalToConstant: 42),
            locationView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor)
        ])
    }

    private func setupTodaysAverageTemperatureViewConstraints() {
        NSLayoutConstraint.activate([
            todaysAverageTemperatureView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            todaysAverageTemperatureView.topAnchor.constraint(equalTo: locationView.bottomAnchor)
        ])
    }

    private func setupForecastCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            forecastCollectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 226),
            forecastCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            forecastCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            forecastCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
    }

}
extension UIView
{
  func topColoured()
  {
     let colouredTopBlack = UIView()
     addSubview(colouredTopBlack)
     colouredTopBlack.translatesAutoresizingMaskIntoConstraints = false
    colouredTopBlack.backgroundColor = UIColor(named: "Light Turqoise")

     NSLayoutConstraint.activate([
        colouredTopBlack.topAnchor.constraint(equalTo: topAnchor),
        colouredTopBlack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        colouredTopBlack.widthAnchor.constraint(equalTo: widthAnchor),
    ])
  }
}
