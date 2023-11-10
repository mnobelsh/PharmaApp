//
//  ServiceTableViewCell.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 10/11/23.
//

import UIKit

final class ServiceTableViewCell: UITableViewCell {

  static var reuseIdentifier: String { String(describing: self) }
  
  private lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  private lazy var serviceImageView: UIImageView = UIImageView(image: .venuePlaceholder)
  private lazy var serviceNameLabel: Label = Label(text: "PCR Swab Test (Drive Thru) Hasil 1 Hari Kerja", font: .gilroy(weight: .semibold, size: 16))
  private lazy var priceLabel: Label = Label(text: "Rp. 1.400.000", font: .gilroy(weight: .semibold, size: 16), color: .primaryOrange)
  private lazy var venueImageView: UIImageView = UIImageView(image: .hospitalIcon)
  private lazy var venueLabel: Label = Label(text: "Lenmarc Surabaya", font: .gilroy(weight: .semibold, size: 16), color: .primaryGrey)
  private lazy var locationImageView: UIImageView = UIImageView(image: .locationPinIcon)
  private lazy var locationLabel: Label = Label(text: "Dukuh Pakis, Surabaya", font: .gilroy(weight: .regular, size: 14), color: .secondaryGrey)
  
  private lazy var serviceImageViewWidthConstraint = serviceImageView.widthAnchor.constraint(equalToConstant: 50)

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = .clear
    selectionStyle = .none
  
    serviceImageView.layer.masksToBounds = true
    serviceImageView.translatesAutoresizingMaskIntoConstraints = false
    venueImageView.translatesAutoresizingMaskIntoConstraints = false
    locationImageView.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(containerView)
    containerView.addSubview(serviceImageView)
    containerView.addSubview(serviceNameLabel)
    containerView.addSubview(priceLabel)
    containerView.addSubview(venueImageView)
    containerView.addSubview(venueLabel)
    containerView.addSubview(locationImageView)
    containerView.addSubview(locationLabel)
    
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      
      serviceNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
      serviceNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
      serviceNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: serviceImageView.leadingAnchor, constant: -10),
      
      priceLabel.topAnchor.constraint(equalTo: serviceNameLabel.bottomAnchor, constant: 12),
      priceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
      priceLabel.trailingAnchor.constraint(lessThanOrEqualTo: serviceImageView.leadingAnchor, constant: -10),
      
      venueImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
      venueImageView.centerYAnchor.constraint(equalTo: venueLabel.centerYAnchor),
      
      venueLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
      venueLabel.leadingAnchor.constraint(equalTo: venueImageView.trailingAnchor, constant: 6),
      venueLabel.trailingAnchor.constraint(lessThanOrEqualTo: serviceImageView.leadingAnchor, constant: -10),
      
      locationImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
      locationImageView.centerYAnchor.constraint(equalTo: locationLabel.centerYAnchor),
      
      locationLabel.topAnchor.constraint(equalTo: venueLabel.bottomAnchor, constant: 8),
      locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 6),
      locationLabel.trailingAnchor.constraint(lessThanOrEqualTo: serviceImageView.leadingAnchor, constant: -10),
      locationLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -15),
      
      serviceImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
      serviceImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      serviceImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
      serviceImageViewWidthConstraint,
      serviceImageView.heightAnchor.constraint(equalToConstant: 150)
    ])
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    serviceImageViewWidthConstraint.constant = containerView.frame.width / 3
    containerView.rounded(radius: 20)
    serviceImageView.layer.cornerRadius = 20
    containerView.dropShadow()
  }
  
}
