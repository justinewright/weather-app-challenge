//
//  HourlyForecastDataSource.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/29.
//

import UIKit

class HourlyForecastDataSource: NSObject, UICollectionViewDataSource {
    let cellType: HourlyCell.Type
    let cellReuseIdentifier = "hourly-forecast-cell-reuse-identifier"

    private var hourlyData: [HourlyWeather] = [] {
        didSet {

        }
    }

    override init() {
        cellType = HourlyCell.self
    }

    func config(data: [HourlyWeather]) {
        DispatchQueue.main.async { [self] in
            hourlyData = data
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCell.reuseIdentifier, for: indexPath) as? HourlyCell else {
            return UICollectionViewCell()
        }
        cell.setup(hourlyWeather: hourlyData[indexPath.row])

        return cell
    }
}
