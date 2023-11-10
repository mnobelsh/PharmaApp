//
//  UIViewController+Extension.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 08/11/23.
//

import UIKit

extension UIViewController {
  
  var loadingController: LoadingController { LoadingController() }
  
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
  
  func showLoading() {
    loadingController.modalPresentationStyle = .overCurrentContext
    present(loadingController, animated: true, completion: nil)
  }
  
  func hideLoading() {
    loadingController.dismiss(animated: true)
  }
  
}
