//
//  LaunchPadController.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 08/11/23.
//  Copyright (c) 2023 All rights reserved.
//

import UIKit
import Combine

final class LaunchPadController: UINavigationController {
    
  private(set) var viewModel: LaunchPadViewModel!
  private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
  
  var topPadding: CGFloat = 0
  
  // SUBVIEWS
  lazy var appNavigationBar: NavigationBar = NavigationBar()
  lazy var sideBarView: SideBarView = SideBarView()
    
  init(viewModel: LaunchPadViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewDidLoad()
    viewModel.viewDidLoad()
    bindViewModel()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    topPadding = appNavigationBar.frame.height
  }
    
}

// MARK: Private Functions
private extension LaunchPadController {
    
  func setupViewDidLoad() {
    sideBarView.delegate = self
    sideBarView.isHidden = true
    appNavigationBar.delegate = self
    setNavigationBarHidden(true, animated: false)
    view.addSubview(appNavigationBar)
    view.addSubview(sideBarView)
  
    NSLayoutConstraint.activate([
      appNavigationBar.topAnchor.constraint(equalTo: view.topAnchor),
      appNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      appNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      sideBarView.topAnchor.constraint(equalTo: view.topAnchor),
      sideBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      sideBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      sideBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    viewControllers = [HomeViewController(viewModel: HomeViewModelImpl(request: .init()))]
  }
  
  func bindViewModel() {
  }
    
  func navigateToAccountViewController() {
    guard viewControllers.last?.isKind(of: AccountViewController.self) == false else { return }
    self.pushViewController(AccountViewController(viewModel: AccountViewModelImpl(request: .init())), animated: true)
  }
  
}

extension LaunchPadController: NavigationBarDelegate {
  
  func navigationBar(_ navigationBar: NavigationBar, didTapMenu menuButton: UIButton) {
    sideBarView.isHidden = false
  }
  
}

extension LaunchPadController: SideBarViewDelegate {
  
  func sideBarViewDidTapMyProfile(_ sideBarView: SideBarView) {
    sideBarView.animateHideContentView()
    navigateToAccountViewController()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
      NotificationCenter.default.post(name: .didSelectSideBarMenu, object: nil, userInfo: ["index": 0])
    }
  }
  
  func sideBarViewDidTapSetting(_ sideBarView: SideBarView) {
    sideBarView.animateHideContentView()
    navigateToAccountViewController()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
      NotificationCenter.default.post(name: .didSelectSideBarMenu, object: nil, userInfo: ["index": 1])
    }
  }
  
  func sideBarViewDidTapLogout(_ sideBarView: SideBarView) {
    print("LOGOUT")
  }
  
}
