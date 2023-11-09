//
//  ProfileContainerView.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 09/11/23.
//

import UIKit

class ProfileContainerView: UIView {
  
  lazy var inputFormView: InputFormView = InputFormView(items: [.firstName,.lastName,.email,.phoneNumber,.id])
  private lazy var userInfoCardView: UserInfoCardView = UserInfoCardView()
  private lazy var additionalInfoView: AdditionalInfoView = AdditionalInfoView()
  private lazy var saveButton: RoundedFilledButton = RoundedFilledButton(radius: 8)

  init() {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .white
    
    addSubview(userInfoCardView)
    addSubview(inputFormView)
    addSubview(additionalInfoView)
    addSubview(saveButton)
    
    saveButton.setTitle("Simpan Profile", for: .normal)
    NSLayoutConstraint.activate([
      userInfoCardView.topAnchor.constraint(equalTo: topAnchor),
      userInfoCardView.leadingAnchor.constraint(equalTo: leadingAnchor),
      userInfoCardView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      inputFormView.topAnchor.constraint(equalTo: userInfoCardView.bottomAnchor, constant: 30),
      inputFormView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
      inputFormView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
      
      additionalInfoView.topAnchor.constraint(equalTo: inputFormView.bottomAnchor, constant: 40),
      additionalInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
      additionalInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
      
      saveButton.heightAnchor.constraint(equalToConstant: 40),
      saveButton.topAnchor.constraint(equalTo: additionalInfoView.bottomAnchor, constant: 30),
      saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
      saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
      saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    rounded(radius: 20)
    userInfoCardView.rounded(radius: 20)
    dropShadow(radius: 12, opacity: 0.1)
  }

}

private class AdditionalInfoView: UIStackView {
  
  private lazy var infoImageView: UIImageView = UIImageView(image: .infoIcon)
  private lazy var descriptionLabel: Label = Label(text: "Pastikan profile anda terisi dengan benar, data pribadi anda terjamin keamanannya", font: .gilroy(weight: .light, size: 14), color: .primaryText)
  
  init() {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    axis = .horizontal
    spacing = 12
    alignment = .top
    
    addArrangedSubview(infoImageView)
    addArrangedSubview(descriptionLabel)
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
