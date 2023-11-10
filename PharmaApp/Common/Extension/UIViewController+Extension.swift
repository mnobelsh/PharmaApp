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
    dismiss(animated: true)
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let alertAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel)
    alert.addAction(alertAction)
    present(alert, animated: true)
  }
  
  func showLoading() {
    let loadingController = LoadingController()
    loadingController.modalTransitionStyle = .crossDissolve
    loadingController.modalPresentationStyle = .overCurrentContext
    present(loadingController, animated: true, completion: nil)
  }
  
  func hideLoading() {
    dismiss(animated: true)
  }
  
}
