//
//  ProductCollectionViewCell.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 10/11/23.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
  
  static var reuseIdentifier: String { String(describing: self) }
  
  private lazy var starImageView: UIImageView = UIImageView(image: .starIcon)
  private lazy var productImageView: UIImageView = UIImageView(image: .microscope)
  private lazy var ratingLabel: Label = Label(text: "5", font: .gilroy(weight: .bold, size: 14), color: .secondaryGrey)
  private lazy var productNameLabel: Label = Label(text: "Suntik Steril", font: .gilroy(weight: .semibold, size: 16))
  private lazy var priceLabel: Label = Label(text: "Rp. 10.000", font: .gilroy(weight: .semibold, size: 14), color: .primaryOrange)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    productImageView.translatesAutoresizingMaskIntoConstraints = false
    starImageView.translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .white
    
    contentView.addSubview(starImageView)
    contentView.addSubview(productImageView)
    contentView.addSubview(ratingLabel)
    contentView.addSubview(productNameLabel)
    contentView.addSubview(priceLabel)
    
    NSLayoutConstraint.activate([
      starImageView.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: -5),
      starImageView.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor),
      
      ratingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      
      productImageView.topAnchor.constraint(greaterThanOrEqualTo: ratingLabel.bottomAnchor, constant: 10),
      productImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      productImageView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 10),
      productImageView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -10),
      productImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 80),
      
      productNameLabel.topAnchor.constraint(greaterThanOrEqualTo: productImageView.bottomAnchor, constant: 10),
      productNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      productNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -10),
      productNameLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -5),
      
      priceLabel.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -20),
      priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      priceLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -10),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    rounded(radius: 16)
    dropShadow()
  }
    
}
