//
//  ForecastCollectionView.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/30.
//

import Foundation

import UIKit
import SwiftUI
import Combine

class ForecastCollectionView: UIView {
    private let forecastCellReuseIdentifier = "forecast-cell-reuse-identifier"
    private lazy var collectionView: UICollectionView! = nil

    private var viewModel: ForecastCollectionViewModel!
    private var cancellables: Set<AnyCancellable> = []

    required init(viewModel: ForecastCollectionViewModel = ForecastCollectionViewModel()) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        setupView()
        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionView)


        self.collectionView = collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(ForecastCell.self,
                                     forCellWithReuseIdentifier: forecastCellReuseIdentifier)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupBindings() {
        viewModel.$weatherForecast
            .receive(on: DispatchQueue.main)
            .sink { _ in

            } receiveValue: { _ in
                self.collectionView.reloadData()
            }.store(in: &cancellables)
    }

}

extension ForecastCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.weatherForecast.count > 0 ? viewModel.forecastedDays : 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: forecastCellReuseIdentifier, for: indexPath) as? ForecastCell else {
            return UICollectionViewCell()
        }
        cell.setup(weatherModel: viewModel.weatherForecast[indexPath.row])
        return cell
    }

}
extension ForecastCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        let size = CGSize(width: ForecastCell.width, height: ForecastCell.width)
        return size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        10
//    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
//    }
}

struct IntegratedForecastCollectionView: UIViewRepresentable {

    func makeUIView(context: UIViewRepresentableContext<IntegratedForecastCollectionView>) -> ForecastCollectionView {
        return ForecastCollectionView()
    }

    func updateUIView(_ uiView: ForecastCollectionView, context: UIViewRepresentableContext<IntegratedForecastCollectionView>) {}

}

struct ForecastCollectionViewa: View {

    var body: some View {
        ZStack {
            Color.init(.black)
            VStack {
                IntegratedForecastCollectionView()
            }.foregroundColor(.black)
        }

    }
}

struct ForecastCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForecastCollectionViewa()
                .preferredColorScheme(.dark)
        }
    }
}
