//
//  LocationHeaderViewController.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//  
//

import UIKit

class LocationHeaderViewController: UIViewController {
    private var locationHeaderLabel: UILabel!
    private var locationString = ""

    init() {
        super.init(nibName: nil, bundle: nil)
        locationHeaderLabel = UILabel().White.SystemFont18
        locationHeaderLabel.textAlignment = .center
        locationHeaderLabel.backgroundColor = UIColor(named: "Light Turqoise")
        locationHeaderLabel.text = locationString
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Properties
    var presenter: ViewToPresenterLocationHeaderProtocol?

    private func setupView() {
        
        locationHeaderLabel = presenter?.createHeaderLabel
        locationHeaderLabel.text = locationString
        self.view.addSubview(locationHeaderLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        self.locationHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationHeaderLabel.topAnchor.constraint(equalTo: view.topAnchor),
            locationHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationHeaderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationHeaderLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension LocationHeaderViewController: PresenterToViewLocationHeaderProtocol {
    func refresh(data address: String) {
        DispatchQueue.main.async { [self] in
            locationString = address
            locationHeaderLabel.text = locationString
        }
    }
}
