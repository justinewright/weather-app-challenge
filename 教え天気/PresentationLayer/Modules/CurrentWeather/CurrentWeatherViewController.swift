//
//  HourlyWeatherViewController.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//  
//

import UIKit

class CurrentWeatherViewController: UIViewController {

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Properties
    var presenter: ViewToPresenterCurrentWeatherProtocol?
    private var currentWeatherView: CustomCurrentWeatherView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        currentWeatherView = CustomCurrentWeatherView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.view = currentWeatherView
        setupConstraints()
    }

    private func setupConstraints() {
        self.currentWeatherView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentWeatherView.topAnchor.constraint(equalTo: view.topAnchor),
            currentWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currentWeatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currentWeatherView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CurrentWeatherViewController: PresenterToViewCurrentWeatherProtocol{
    func refresh(data currentWeather: CurrentWeather) {
        DispatchQueue.main.async {
            self.currentWeatherView.update(currentWeather: currentWeather)
        }
    }

    // TODO: Implement View Output Methods
}
