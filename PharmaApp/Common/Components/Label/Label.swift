//
//  Label.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 08/11/23.
//

import UIKit

class Label: UILabel {
  
  init(text: String? = nil, font: UIFont = .gilroy(weight: .regular, size: 16), color: UIColor = .primaryText) {
    super.init(frame: .zero)
    self.numberOfLines = 0
    self.text = text
    self.font = font
    self.textColor = color
    self.translatesAutoresizingMaskIntoConstraints = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
