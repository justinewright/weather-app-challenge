//
//  LocationCollectionView.swift
//  教え天気
//
//   Created by Justine Wright on 2021/09/05.
//

import UIKit
import Combine

class LocationCollectionView: UIView {
    private let locationCellReuseIdentifier = "location-cell-reuse-identifier"
    private lazy var collectionView: UICollectionView! = nil
    var selectedCell = 0
    var callback: ((_ id: Int) -> Void)?
//    private var viewModel: ForecastCollectionViewModel!
//    private var cancellables: Set<AnyCancellable> = []

    required override init(frame: CGRect) {
        super.init(frame: .zero)

        print("test")
//        self.viewModel = viewModel
        setupView()
        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        print("setup")
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

        setupConstraints()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }

    private func setupConstraints() {
        print("constraining")
    }

    private func setupBindings() {
//        viewModel.$weatherForecast
//            .receive(on: DispatchQueue.main)
//            .sink { _ in
//
//            } receiveValue: { _ in
//                self.collectionView.reloadData()
//            }.store(in: &cancellables)
    }

}

extension LocationCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: locationCellReuseIdentifier, for: indexPath) as? LocationCell else {
            return UICollectionViewCell()
        }
        cell.setup(text: locations[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath.row)
        callback?(indexPath.row)
        selectedCell = indexPath.row

    }
}

extension LocationCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width:UIScreen.main.bounds.width, height: 50)
        return size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
