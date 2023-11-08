//
//  UIApplication+Extension.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 07/11/23.
//

import UIKit

extension UIApplication {
  
  static var sceneDelegate: SceneDelegate? {
      return UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
  }
  
  public class var keyWindow: UIWindow? {
      if #available(iOS 15, *) {
          return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
              .windows
              .first(where: { $0.isKeyWindow })
      } else {
          return UIApplication.shared.windows.first(where: { $0.isKeyWindow })
      }
  }
  
  static var currentAppVersion: String? {
      return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
  }
  
}
