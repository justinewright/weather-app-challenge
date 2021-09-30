//
//  LocationListCollectionView.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/16.
//

import UIKit

class LocationsCollectionView: UIView {
    private let locationCellReuseIdentifier = "location-cell-reuse-identifier"
    private lazy var collectionView: UICollectionView! = nil
    private var addresses: [String] = []
    private var currentAddress: String = "Taito, Japan"

    var selectedCell = 0
    var callback: ((_ id: Int) -> Void)?

    required override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        backgroundColor = .green
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        self.addSubview(collectionView)
        self.collectionView = collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(LocationCell.self,
                                     forCellWithReuseIdentifier: locationCellReuseIdentifier)
        self.collectionView.isUserInteractionEnabled = false

    }

    func reload(locationAddresses data: [String], currentAddress: String = "") {
        DispatchQueue.main.async {
            self.addresses = data
            self.currentAddress = currentAddress
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.frame = self.collectionView.frame
        }
    }
}

extension LocationsCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addresses.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: locationCellReuseIdentifier, for: indexPath) as? LocationCell else {
            return UICollectionViewCell()
        }
        cell.setup(text: addresses[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

}

extension LocationsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width:UIScreen.main.bounds.width, height: 50)
        return size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
