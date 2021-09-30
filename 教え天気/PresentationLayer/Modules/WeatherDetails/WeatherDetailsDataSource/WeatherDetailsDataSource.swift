//
//  WeatherDetailsDataSource.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/30.
//

import UIKit

class WeatherDetailsDataSource: NSObject, UICollectionViewDataSource {
    let cellType: DetailsCell.Type

    private var detailsData: DailyWeather!

    override init() {
        cellType = DetailsCell.self
    }

    func config(data: DailyWeather) {
        DispatchQueue.main.async { [self] in
            detailsData = data
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCell.reuseIdentifier, for: indexPath) as? DetailsCell else {
            return UICollectionViewCell()
        }
        cell.update(dailyWeather: detailsData)

        return cell
    }
}

