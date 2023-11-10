//
//  UIFont+Extension.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 08/11/23.
//

import UIKit

extension UIFont {
  
  static func gilroy(weight: UIFont.Weight, size: CGFloat) -> UIFont {
    var font: UIFont?
    switch weight {
    case .light: font = UIFont(name: "Gilroy-Light", size: size)
    case .semibold: font = UIFont(name: "Gilroy-SemiBold", size: size)
    case .bold: font = UIFont(name: "Gilroy-Bold", size: size)
    default: font = UIFont(name: "Gilroy-Regular", size: size)
    }
    return font ?? UIFont.systemFont(ofSize: size, weight: weight)
  }
  
}
