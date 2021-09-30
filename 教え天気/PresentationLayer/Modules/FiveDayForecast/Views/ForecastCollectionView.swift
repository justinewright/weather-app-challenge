//
//  ForecastCollectionView.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//

import UIKit

class ForecastCollectionView: UIView {
    private let forecastCellReuseIdentifier = "forecast-cell-reuse-identifier"
    private lazy var collectionView: UICollectionView! = nil
    private var dailyForecast: [DailyWeather] = []
    private var selectedCell: Int = 0

    required init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        self.addSubview(collectionView)

        self.collectionView = collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(ForecastCell.self,
                                     forCellWithReuseIdentifier: forecastCellReuseIdentifier)

        setupConstraints()
    }

    private func setupConstraints() {

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

    public func refresh(data: [DailyWeather]) {
        DispatchQueue.main.async {
            self.dailyForecast = data
            self.collectionView.reloadData()
        }
    }

}

extension ForecastCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return dailyForecast.isEmpty ? 0 : dailyForecast.first?.icon == "-1" ? 0 : 5
        return dailyForecast.isEmpty ? 0 : 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: forecastCellReuseIdentifier, for: indexPath) as? ForecastCell else {
            return UICollectionViewCell()
        }

        cell.update(dailyWeather: dailyForecast[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = indexPath.row
    }
}

extension ForecastCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: ForecastCell.flexibleWidth, height: ForecastCell.flexibleWidth)
        return size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
