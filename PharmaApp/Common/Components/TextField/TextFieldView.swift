//
//  TextFieldView.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 09/11/23.
//

import UIKit

class TextFieldView: UIStackView {
  
  enum TextFieldType {
    case secure
    case `default`
  }
  
  private lazy var titleLabel: Label = Label(font: .gilroy(weight: .semibold, size: 16), color: .accent)
  lazy var textField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.keyboardType = .default
    textField.textColor = .accent
    textField.font = .gilroy(weight: .semibold, size: 14)
    return textField
  }()
  private lazy var textFieldContainerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    return view
  }()
  private lazy var alertLabel: Label = Label(font: .gilroy(weight: .regular, size: 12), color: .primaryRed)
  private lazy var rightButton: ImageButton = ImageButton(image: nil)
  private lazy var textFieldStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [textField, rightButton])
    stackView.axis = .horizontal
    stackView.spacing = 10
    stackView.alignment = .center
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.backgroundColor = .clear
    return stackView
  }()
  
  init(
    type: TextFieldType = .default,
    title: String? = nil,
    placeholder: String? = nil,
    rightButtonImage: UIImage? = nil
  ) {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    axis = .vertical
    spacing = 16
    distribution = .fill
    alignment = .fill
    addSubview(titleLabel)
    configureTextFieldContainerView()
    
    addArrangedSubview(titleLabel)
    addArrangedSubview(textFieldContainerView)
    addArrangedSubview(alertLabel)
    
    setPlaceholder(text: placeholder)
    setTitle(title: title)
    setAlert(text: nil)
    setRightButton(image: rightButtonImage)
    setCustomSpacing(8, after: textFieldContainerView)
    
    if type == .secure {
      setRightButton(image: rightButtonImage ?? .eyeIcon)
      rightButton.addTarget(self, action: #selector(onRightButtonDidTap(_:)), for: .touchUpInside)
    }
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    textFieldContainerView.rounded(radius: 8)
    textFieldContainerView.dropShadow(offset: .init(width: 0, height: 3), radius: 6, opacity: 0.1)
  }
  
  private func configureTextFieldContainerView() {
    textFieldContainerView.addSubview(textFieldStackView)
    addSubview(textFieldContainerView)
    NSLayoutConstraint.activate([
      rightButton.heightAnchor.constraint(equalToConstant: 18),
      rightButton.widthAnchor.constraint(equalToConstant: 18),
      
      textFieldStackView.topAnchor.constraint(equalTo: textFieldContainerView.topAnchor, constant: 12),
      textFieldStackView.leadingAnchor.constraint(equalTo: textFieldContainerView.leadingAnchor, constant: 20),
      textFieldStackView.trailingAnchor.constraint(equalTo: textFieldContainerView.trailingAnchor, constant: -20),
      textFieldStackView.bottomAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: -12),
    ])
  }
  
  func setTitle(title: String?) {
    titleLabel.text = title
    titleLabel.isHidden = title == nil
  }
  
  func setPlaceholder(text: String?) {
    guard let text = text else {
      textField.attributedPlaceholder = nil
      return
    }
    textField.attributedPlaceholder = NSAttributedString(string: text, attributes: [
      .foregroundColor: UIColor.tertiaryGrey,
      .font: UIFont.gilroy(weight: .regular, size: 14)
    ])
  }
  
  func setAlert(text: String?) {
    self.alertLabel.text = text
    UIView.animate(withDuration: 0.2) {
      self.alertLabel.isHidden = text == nil
      self.layoutIfNeeded()
    }
  }
  
  func setRightButton(image: UIImage?) {
    self.rightButton.setBackgroundImage(image, for: .normal)
    self.rightButton.isHidden = image == nil
  }
  
  @objc
  private func onRightButtonDidTap(_ sender: UIButton) {
    textField.isSecureTextEntry.toggle()
  }
  
}
