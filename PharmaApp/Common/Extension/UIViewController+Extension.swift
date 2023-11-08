//
//  UIViewController+Extension.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 08/11/23.
//

import UIKit

extension UIViewController {
  
  var launchPadController: LaunchPadController? {
    return self.navigationController as? LaunchPadController
  }
  
}
