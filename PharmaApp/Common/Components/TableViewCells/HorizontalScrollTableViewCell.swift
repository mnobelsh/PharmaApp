//
//  HorizontalScrollTableViewCell.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 10/11/23.
//

import UIKit

final class HorizontalScrollTableViewCell: UITableViewCell {

  static var reuseIdentifier: String { String(describing: self) }
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.estimatedItemSize = CGSize(width: 100, height: 100)
    layout.itemSize = UICollectionViewFlowLayout.automaticSize
    layout.minimumLineSpacing = 15
    layout.minimumInteritemSpacing = 15
    let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
    collectionView.contentInsetAdjustmentBehavior = .never
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(collectionView)
    NSLayoutConstraint.activate([
      
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
