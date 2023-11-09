//
//  UIView+Extension.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 08/11/23.
//

import UIKit

extension UIView {
  
  func rounded(radius: CGFloat? = nil, corners: UIRectCorner = .allCorners) {
    self.layer.masksToBounds = false
    self.layer.maskedCorners = corners.caCornerMask
    self.layer.cornerCurve = .circular
    if let radius = radius {
      self.layer.cornerRadius = radius
    } else {
      self.layer.cornerRadius = self.frame.height/2
    }
  }
  
  func dropShadow(offset: CGSize = .zero, radius: CGFloat = 4, opacity: Float = 0.15, color: UIColor = .black) {
    self.layer.masksToBounds = false
    self.layer.shadowColor = color.cgColor
    self.layer.shadowOffset = offset
    self.layer.shadowOpacity = opacity
    self.layer.shadowRadius = radius
    self.layer.shouldRasterize = true
    self.layer.rasterizationScale = UIScreen.main.scale
  }
  
}

extension UIRectCorner {
  
  var caCornerMask: CACornerMask {
    var cornersMask = CACornerMask()
    if self.contains(.topLeft) {
        cornersMask.insert(.layerMinXMinYCorner)
    }
    if self.contains(.topRight) {
        cornersMask.insert(.layerMaxXMinYCorner)
    }
    if self.contains(.bottomLeft) {
        cornersMask.insert(.layerMinXMaxYCorner)
    }
    if self.contains(.bottomRight) {
        cornersMask.insert(.layerMaxXMaxYCorner)
    }
    return cornersMask
  }
  
}
