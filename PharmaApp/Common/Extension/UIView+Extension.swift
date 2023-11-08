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
  
  func dropShadow(offset: CGSize = .zero, radius: CGFloat = 1, opacity: Float = 0.25) {
    self.layer.masksToBounds = false
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    self.layer.shadowOffset = offset
    self.layer.shadowOpacity = opacity
    self.layer.shadowRadius = radius
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
