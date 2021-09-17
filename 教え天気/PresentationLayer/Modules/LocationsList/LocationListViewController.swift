//
//  LocationListViewController.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/16.
//  
//

import UIKit

class LocationListViewController: UIViewController {

    private lazy var locationListCollection = LocationsCollectionView()
    private lazy var searchBar = LocationSearchBarViewController()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.refresh()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterLocationListProtocol?

    private func setupView() {
        self.view.addSubview(locationListCollection)
        self.view.addSubview( self.presenter!.addButton )
        self.presenter?.addButton.translatesAutoresizingMaskIntoConstraints = false
        self.setupConstraints()
    }

    private func setupConstraints () {
        self.presenter?.addButton.translatesAutoresizingMaskIntoConstraints = false
        self.presenter?.addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.presenter?.addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.presenter?.addButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.presenter?.addButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }


}

extension LocationListViewController: PresenterToViewLocationListProtocol{

    func refresh(locations: [String]) {
        locationListCollection.reload(locationAddresses: locations)
    }

    // TODO: Implement View Output Methods
}
