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
  private lazy var welcomeContainerView: AuthenticationContainerView = AuthenticationContainerView(pageType: .login)
  
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
    inputFormView.delegate = self
  }
  
  func bindViewModel() {
    viewModel.loginState
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        self?.didReceiveLoginState(state)
      }
      .store(in: &cancellables)
  }
  
  func didReceiveLoginState(_ state: State?) {
    switch state {
    case .loading:
      showLoading()
    case .success:
      hideLoading()
      AppFlowCoordinator.shared.setLaunchPadFlow()
    case .error(let errorState):
      handleErrorState(error: errorState)
    default: hideLoading()
    }
  }
  
  func handleErrorState(error: ErrorState) {
    switch error {
    case .backend(let description), .uiError(let description):
      showAlert(title: description, message: nil)
    default:
      showAlert(title: "Something went wrong", message: "Please try again later")
    }
  }
  
  func navigateToRegister() {
    let registerVM: RegisterViewModel = RegisterViewModelImpl(request: .init())
    let registerVC: RegisterViewController = RegisterViewController(viewModel: registerVM)
    navigationController?.pushViewController(registerVC, animated: true)
  }
    
}

extension LoginViewController: AuthenticationContainerViewDelegate {
  
  func authContainerView(_ containerView: AuthenticationContainerView, didTapActionButton button: RoundedFilledButton) {
    viewModel.didTapLogin()
  }

  func authContainerView(_ containerView: AuthenticationContainerView, didTapRedirectionLabel label: UILabel, sender: UITapGestureRecognizer, willNavigateTo destination: AuthenticationContainerView.PageType) {
    navigateToRegister()
  }

}

extension LoginViewController: InputFormViewDelegate {
  
  
  func inputFormField(_ inputFormView: InputFormView, shouldChangeCharactersIn textFieldView: TextFieldView, updatedText: String, forItem item: InputFormItem) -> Bool {
    switch item {
    case .email:
      viewModel.didSetEmail(updatedText)
    case .password:
      viewModel.didSetPassword(updatedText)
    default: break
    }
    return true
  }
  

}
