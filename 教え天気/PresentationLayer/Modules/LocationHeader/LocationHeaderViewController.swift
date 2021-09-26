//
//  LocationHeaderViewController.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//  
//

import UIKit

class LocationHeaderViewController: UIViewController {

    // MARK: - Initialization
    init() {
        locationHeaderLabel = UILabel()
        super.init(nibName: nil, bundle: nil)
        presenter?.updateView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        setupView()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterLocationHeaderProtocol?
    private var locationHeaderLabel: UILabel!
    private var addressString: String = ""
    
    private func setupView() {
        self.view.addSubview(locationHeaderLabel)
        presenter?.updateView()
        setupConstraints()
        applyStyle()
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

    private func applyStyle() {
        locationHeaderLabel = UILabel().White.SystemFont18
        locationHeaderLabel.textAlignment = .center
        locationHeaderLabel.backgroundColor = UIColor(named: "Light Turqoise")
        self.locationHeaderLabel.text = addressString
    }
}

// MARK: - PresenterToView Protocol
extension LocationHeaderViewController: PresenterToViewLocationHeaderProtocol {
    func showAddress(withAddress address: String) {
        self.addressString = address
    }
}
