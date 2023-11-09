//
//  Button.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 08/11/23.
//

import UIKit

class Button: UIButton {
  
  override var isEnabled: Bool {
    didSet { didSetIsEnabled() }
  }
  
  init() {
    super.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    translatesAutoresizingMaskIntoConstraints = false
    setTitleColor(.accent, for: .normal)
    titleLabel?.font = .gilroy(weight: .semibold, size: 14)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func didSetIsEnabled() {}
  
}

// MARK: - Rounded Button
final class RoundedFilledButton: Button {
  
  var defaultBackgroundColor: UIColor?
  private var cornerRadius: CGFloat = 0
  
  init(title: String?, radius: CGFloat = 8, defaultBackgroundColor: UIColor = .accent) {
    self.defaultBackgroundColor = defaultBackgroundColor
    super.init()
    self.cornerRadius = radius
    self.setTitle(title, for: .normal)
    setTitleColor(.white, for: .normal)
    backgroundColor = defaultBackgroundColor
    setCornerRadius()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutIfNeeded() {
    super.layoutIfNeeded()
    setCornerRadius()
  }
  
  override func didSetIsEnabled() {
    super.didSetIsEnabled()
    backgroundColor = isEnabled ? defaultBackgroundColor : .secondaryGrey
  }
  
  private func setCornerRadius() {
    cornerRadius == 0 ? rounded() : rounded(radius: cornerRadius)
  }
  
}

// MARK: - IMAGE BUTTON
final class ImageButton: Button {
  
  init(image: UIImage?) {
    super.init()
    self.contentMode = .scaleAspectFit
    self.setBackgroundImage(image, for: .normal)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
