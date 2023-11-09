//
//  AppFlowCoordinator.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 07/11/23.
//

import UIKit

final class AppFlowCoordinator {
  
  static let shared: AppFlowCoordinator = AppFlowCoordinator()
  
  var window: UIWindow?
  lazy var mainNavigationController: UINavigationController = {
    let navigationController = UINavigationController()
    navigationController.setNavigationBarHidden(false, animated: false)
    navigationController.navigationBar.isHidden = false
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .white
    navigationController.navigationBar.standardAppearance = appearance
    navigationController.navigationBar.scrollEdgeAppearance = appearance
    return navigationController
  }()
  
  private init() {}
  
  func launchApp(window: UIWindow?) {
    self.window = window
    window?.makeKeyAndVisible()
    setAuthenticationFlow()
  }
  
  func setAuthenticationFlow() {
    mainNavigationController.setViewControllers([LoginViewController(viewModel: LoginViewModelImpl(request: .init()))], animated: true)
    window?.rootViewController = mainNavigationController
  }
  
  func setLaunchPadFlow() {
    window?.rootViewController = LaunchPadController(viewModel: LaunchPadViewModelImpl(request: .init()))
  }
  
}
