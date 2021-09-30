//
//  ReusableCollectionView.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/29.
//

import UIKit

public protocol Reusable: AnyObject {
  /// The reuse identifier to use when registering and later dequeuing a reusable cell
  static var reuseIdentifier: String { get }
}

public extension Reusable {
  /// By default, use the name of the class as String for its reuseIdentifier
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

class ReusableCollectionView: UIView {

    private(set) var collectionView: UICollectionView! = nil
    private var selectedCell: Int = 0
    private let cellWidth: CGFloat
    private let cellHeight: CGFloat

    required init(cellWidth: CGFloat, cellHeight: CGFloat) {
        self.cellWidth = cellWidth
        self.cellHeight = cellHeight
        super.init(frame: .zero)
    
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    final func register<T: UICollectionViewCell>(cellType: T.Type)
       where T: Reusable {
           collectionView.register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
           self.collectionView.delegate = self
     }

    private func setupView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .init(width: cellWidth, height: cellHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        self.addSubview(collectionView)

        self.collectionView = collectionView
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

    public func refresh() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension ReusableCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = indexPath.row
    }
}

extension ReusableCollectionView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

}
