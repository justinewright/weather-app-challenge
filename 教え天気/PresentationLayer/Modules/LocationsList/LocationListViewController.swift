//
//  LocationListViewController.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/16.
//  
//

import UIKit

class LocationListViewController: UIViewController {

    // MARK: - Initialization
    init() {
        super.init(nibName: nil, bundle: nil)
        presenter?.updateView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Locations"
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        presenter?.updateView()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterLocationListProtocol?
    private lazy var locationListCollection = LocationsCollectionView()
    private lazy var searchBar = LocationSearchBarViewController()

    private func setupView() {
        self.view.addSubview(locationListCollection)
        self.view.addSubview( self.addButton )
        self.addButton.translatesAutoresizingMaskIntoConstraints = false
        self.setupConstraints()
    }

    private func setupConstraints () {
        self.addButton.translatesAutoresizingMaskIntoConstraints = false
        self.addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.addButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.addButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    lazy var addButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.tintColor = .black
        button.layer.cornerRadius = 20

        button.setTitle("+", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)

        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(addLocationButtonPressed), for: .touchUpInside)
        return button
    }()

    @objc func addLocationButtonPressed() {
        presenter?.addLocationButtonPressed()
    }

}

extension LocationListViewController: PresenterToViewLocationListProtocol {
    func showLocations(withAddresses addresses: [String]) {
        self.locationListCollection.reload(locationAddresses: addresses)

    }

    // TODO: Implement View Output Methods
}
