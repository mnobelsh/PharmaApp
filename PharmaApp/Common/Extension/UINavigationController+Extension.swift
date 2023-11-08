//
//  UINavigationController+Extension.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 08/11/23.
//

import UIKit

extension UINavigationController: UIGestureRecognizerDelegate {
  
  override open func viewDidLoad() {
      super.viewDidLoad()
      interactivePopGestureRecognizer?.delegate = self
      navigationBar.isTranslucent = true
  }
  
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
      return viewControllers.count > 1
  }
  
}
