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
//        locationHeaderLabel = UILabel()
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
    private var addressString: String = ""
    
    private func setupView() {
        presenter?.updateView()
    }
}

// MARK: - PresenterToView Protocol
extension LocationHeaderViewController: PresenterToViewLocationHeaderProtocol {
    func showAddress(withAddress address: String) {
        self.addressString = address
        self.parent?.parent?.parent?.navigationItem.title = self.addressString
    }
}
