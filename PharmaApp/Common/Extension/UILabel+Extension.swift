//
//  UILabel+Extension.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 08/11/23.
//

import UIKit

extension UILabel {
  
  func setAttributedText(
    text: String?,
    defaultAttributes: [NSMutableAttributedString.Key: Any]?,
    attributedText: String? = nil,
    secondAttributes: [NSMutableAttributedString.Key: Any]? = nil
  ) {
    guard let text = text else {
      self.text = nil
      self.attributedText = nil
      return
    }
    let mutableAttributedString = NSMutableAttributedString(string: text, attributes: defaultAttributes)
    if let attributedText = attributedText {
      let range = NSString(string: text).range(of: attributedText)
      mutableAttributedString.setAttributes(secondAttributes, range: range)
    }
    self.text = text
    self.attributedText = mutableAttributedString
  }
  
  
}
