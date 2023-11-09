//
//  LoginViewController.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 08/11/23.
//  Copyright (c) 2023 All rights reserved.
//

import UIKit
import Combine

final class LoginViewController: UIViewController {
  
  private(set) var viewModel: LoginViewModel!
  private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
  
  // SUBVIEWS
  private lazy var forgetPasswordButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitleColor(.accent, for: .normal)
    button.titleLabel?.font = .gilroy(weight: .regular, size: 14)
    button.setTitle("Lupa Password anda ?", for: .normal)
    return button
  }()
  private lazy var inputFormView: InputFormView = InputFormView(items: [.email,.password])
  private lazy var welcomeContainerView: WelcomeContainerView = WelcomeContainerView(pageType: .login)
  
  init(viewModel: LoginViewModel) {
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
    
}

// MARK: Private Functions
private extension LoginViewController {
    
  func setupViewDidLoad() {
    view.backgroundColor = .white
    
    welcomeContainerView.addToView(self.view)
    NSLayoutConstraint.activate([
      welcomeContainerView.topAnchor.constraint(equalTo: view.topAnchor),
      welcomeContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      welcomeContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      welcomeContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
    welcomeContainerView.setInputFormView(inputFormView)
    inputFormView.textFieldViews.last?.setRightTitleButton(button: forgetPasswordButton)
    welcomeContainerView.containerDelegate = self
  }
  
  func bindViewModel() {
  }
  
  func navigateToRegister() {
    let registerVM: RegisterViewModel = RegisterViewModelImpl(request: .init())
    let registerVC: RegisterViewController = RegisterViewController(viewModel: registerVM)
    navigationController?.pushViewController(registerVC, animated: true)
  }
    
}

extension LoginViewController: WelcomeContainerViewDelegate {
  
  func welcomeContainerView(_ containerView: WelcomeContainerView, didTapActionButton button: RoundedFilledButton) {
    AppFlowCoordinator.shared.setLaunchPadFlow()
  }

  func welcomeContainerView(_ containerView: WelcomeContainerView, didTapRedirectionLabel label: UILabel, sender: UITapGestureRecognizer, willNavigateTo destination: WelcomeContainerView.PageType) {
    navigateToRegister()
  }

}
