//
//  UserInfoCardView.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 09/11/23.
//

import UIKit

class UserInfoCardView: UIView {
  
  private lazy var userInfoView: UserInfoView = UserInfoView()

  init() {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .accent
    userInfoView.nameLabel.textColor = .white
    userInfoView.membershipLabel.textColor = .tertiaryGrey
    userInfoView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(userInfoView)
    
    NSLayoutConstraint.activate([
      userInfoView.topAnchor.constraint(equalTo: topAnchor, constant: 27),
      userInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
      userInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
      userInfoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -27),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
