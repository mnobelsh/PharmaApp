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
  
  func showAlert(title: String? = nil, message: String?) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let alertAction: UIAlertAction = UIAlertAction(title: "Ok", style: .default) { action in
      alert.dismiss(animated: true)
    }
    alert.addAction(alertAction)
    present(alert, animated: true)
  }
  
}
