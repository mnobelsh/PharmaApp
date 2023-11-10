//
//  CategoryCollectionViewCell.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 10/11/23.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
  
  static var reuseIdentifier: String { String(describing: self) }
  
  override var isSelected: Bool {
    didSet { didSetIsSelected() }
  }
  
  init() {
    super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

private extension CategoryCollectionViewCell {
  
  func didSetIsSelected() {
    
  }
  
}
