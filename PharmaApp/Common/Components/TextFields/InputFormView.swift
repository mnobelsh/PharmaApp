//
//  InputFormView.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 09/11/23.
//

import UIKit

protocol InputFormViewDelegate: AnyObject {
  func inputFormField(
    _ inputFormView: InputFormView,
    didEndEditing textFieldView: TextFieldView,
    forItem item: InputFormItem
  )
  func inputFormField(
    _ inputFormView: InputFormView,
    didBeginEditing textFieldView: TextFieldView,
    forItem item: InputFormItem
  )
  func inputFormField(
    _ inputFormView: InputFormView,
    shouldChangeCharactersIn textFieldView: TextFieldView,
    updatedText: String,
    forItem item: InputFormItem
  ) -> Bool
}

extension InputFormViewDelegate {
  func inputFormField(
    _ inputFormView: InputFormView,
    didEndEditing textFieldView: TextFieldView,
    forItem item: InputFormItem
  ) {}
  func inputFormField(
    _ inputFormView: InputFormView,
    didBeginEditing textFieldView: TextFieldView,
    forItem item: InputFormItem
  ) {}
}

enum InputFormItem: Int {
  case firstName = 0, lastName, email,
       phoneNumber, id, password, confirmPassword
  
  var title: String {
    switch self {
    case .firstName: return "Nama Depan"
    case .lastName: return "Nama Belakang"
    case .email: return "Email"
    case .phoneNumber: return "No. Telpon"
    case .id: return "No. KTP"
    case .password: return "Password"
    case .confirmPassword: return "Konfirmasi Password"
    }
  }
  
  var placeholder: String {
    switch self {
    case .firstName: return "Masukkan nama depan anda"
    case .lastName: return "Masukkan nama belakang anda"
    case .email: return "Masukkan email anda"
    case .phoneNumber: return "Masukkan nomor telepon anda"
    case .id: return "Masukkan nomor KTP anda"
    case .password: return "Masukan password anda"
    case .confirmPassword: return "Konfirmasi password anda"
    }
  }
}

final class InputFormView: UIStackView {
  
  weak var delegate: InputFormViewDelegate?
  private(set) var items: [InputFormItem]
  private(set) var textFieldViews: [TextFieldView] = []
  
  init(items: [InputFormItem]) {
    self.items = items
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    axis = .vertical
    spacing = 30
    distribution = .fill
    alignment = .fill
    setupTextFieldViews()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func getTextFieldView(for item: InputFormItem) -> TextFieldView? {
    return self.textFieldViews.first(where: { $0.tag == item.rawValue })
  }
  
}

private extension InputFormView {
  
  func setupTextFieldViews() {
    for item in self.items {
      var type: TextFieldView.TextFieldType = .default
      var rightImage: UIImage?
      switch item {
      case .password,.confirmPassword :
        type = .secure
        rightImage = .eyeIcon
      case .phoneNumber, .id: type = .number
      case .email: type = .email
      default: break
      }
      let textFieldView: TextFieldView = TextFieldView(
        type: type,
        title: item.title,
        placeholder: item.placeholder,
        rightButtonImage: rightImage
      )
      textFieldView.tag = item.rawValue
      textFieldView.textField.tag = item.rawValue
      textFieldView.textField.delegate = self
      textFieldViews.append(textFieldView)
      addArrangedSubview(textFieldView)
    }
  }
  
  func getTextFieldView(from textField: UITextField) -> TextFieldView? {
    return textFieldViews.first(where: { $0.tag == textField.tag })
  }
  
  func getItem(from textField: UITextField) -> InputFormItem? {
    return InputFormItem(rawValue: textField.tag)
  }
  
}

extension InputFormView: UITextFieldDelegate {
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    guard let item = getItem(from: textField),
          let textField = getTextFieldView(from: textField)
    else { return }
    delegate?.inputFormField(self, didBeginEditing: textField, forItem: item)
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let item = getItem(from: textField),
          let textField = getTextFieldView(from: textField)
    else { return }
    delegate?.inputFormField(self, didEndEditing: textField, forItem: item)
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let text = textField.text ?? ""
    guard let item = getItem(from: textField),
          let textField = getTextFieldView(from: textField)
    else { return false }
    guard let textRange = Range(range, in: text) else { return false }
    let updatedText = text.replacingCharacters(in: textRange, with: string)
    return delegate?.inputFormField(self, shouldChangeCharactersIn: textField, updatedText: updatedText, forItem: item) ?? true
  }
  
}
