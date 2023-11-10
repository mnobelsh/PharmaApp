//
//  LoginViewModel.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 08/11/23.
//  Copyright (c) 2023 All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
}

protocol LoginViewModelInput {
  func viewDidLoad()
  func didSetEmail(_ email: String?)
  func didSetPassword(_ password: String?)
  func didTapLogin()
}

protocol LoginViewModelOutput {
  var state: Published<State?>.Publisher { get }
  var loginState: Published<State?>.Publisher { get }
}

protocol LoginViewModel: LoginViewModelDelegate, LoginViewModelInput, LoginViewModelOutput {}

struct LoginViewModelRequest {
}

final class LoginViewModelImpl: LoginViewModel {
    
  weak var delegate: LoginViewModelDelegate?
  let request: LoginViewModelRequest
  
  @Inject private var loginUseCase: LoginUseCase
  
  private var email: String?
  private var password: String?
  
  // Output Setter
  @Published private var stateValue: State?
  @Published private var loginStateValue: State?
  
  // Output
  var state: Published<State?>.Publisher { $stateValue }
  var loginState: Published<State?>.Publisher { $loginStateValue }

  init(request: LoginViewModelRequest) {
    self.request = request
  }

}

// MARK: Private Functions
private extension LoginViewModelImpl {
    
}

// MARK: LoginViewModel + LoginViewModelInput
extension LoginViewModelImpl {

  func viewDidLoad() {
  }
  
  func didSetEmail(_ email: String?) {
    self.email = email
  }
  
  func didSetPassword(_ password: String?) {
    self.password = password
  }
  
  func didTapLogin() {
    loginStateValue = nil
    guard let email = email, let password = password else {
      loginStateValue = .error(error: .uiError(description: "Email or password cannot be empty."))
      return
    }
    loginStateValue = .loading
    Task {
      do {
        try await loginUseCase.execute(requestValue: .init(email: email, password: password))
        loginStateValue = .success
      } catch let error as ErrorState {
        loginStateValue = .error(error: error)
      }
    }
  }

}

// MARK: LoginViewModel + LoginViewModelDelegate
extension LoginViewModelImpl {
    
}

