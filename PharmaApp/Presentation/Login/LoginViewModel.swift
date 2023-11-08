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
}

protocol LoginViewModelOutput {
  var responsePublisher: Published<LoginViewModelImpl.Response?>.Publisher { get }
}

protocol LoginViewModel: LoginViewModelDelegate, LoginViewModelInput, LoginViewModelOutput {}

struct LoginViewModelRequest {
}

final class LoginViewModelImpl: LoginViewModel {
    
  enum ViewModelError: Error {
  }
  
  enum Response {
    case error(ViewModelError)
  }

  weak var delegate: LoginViewModelDelegate?
  let request: LoginViewModelRequest
  
  // Output Setter
  @Published private var response: Response?
  
  // Output
  var responsePublisher: Published<LoginViewModelImpl.Response?>.Publisher { $response }

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

}

// MARK: LoginViewModel + LoginViewModelDelegate
extension LoginViewModelImpl {
    
}

