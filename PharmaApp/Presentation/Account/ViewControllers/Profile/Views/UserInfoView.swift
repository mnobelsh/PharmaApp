//
//  UserInfoView.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 09/11/23.
//

import UIKit

class UserInfoView: UIStackView {
  
  lazy var profileImageView: UIImageView = {
    let imageView = UIImageView(image: .profilePlaceholder)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.clipsToBounds = true
    imageView.backgroundColor = .tertiaryGrey
    return imageView
  }()
  lazy var nameLabel: UILabel = Label()
  lazy var membershipLabel: UILabel = Label(text: "Membership BBLK", color: .secondaryGrey)
  private lazy var nameStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [nameLabel,membershipLabel])
    stackView.axis = .vertical
    stackView.spacing = 5
    return stackView
  }()

  init() {
    super.init(frame: .zero)
    addArrangedSubview(profileImageView)
    addArrangedSubview(nameStackView)
    axis = .horizontal
    spacing = 20
    distribution = .fill
    alignment = .center
    NSLayoutConstraint.activate([
      profileImageView.widthAnchor.constraint(equalToConstant: 50),
      profileImageView.heightAnchor.constraint(equalToConstant: 50),
    ])
    nameLabel.setAttributedText(text: "Angga Praja", defaultAttributes: [
      .foregroundColor: UIColor.accent,
      .font: UIFont.gilroy(weight: .regular, size: 18)
    ], attributedText: "Angga", secondAttributes: [
      .foregroundColor: UIColor.accent,
      .font: UIFont.gilroy(weight: .bold, size: 18)
    ])
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    profileImageView.rounded()
  }
  
}
