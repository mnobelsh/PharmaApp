//
//  RegisterViewModel.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 08/11/23.
//  Copyright (c) 2023 All rights reserved.
//

import Foundation

protocol RegisterViewModelDelegate: AnyObject {
}

protocol RegisterViewModelInput {
  func viewDidLoad()
}

protocol RegisterViewModelOutput {
  var responsePublisher: Published<RegisterViewModelImpl.Response?>.Publisher { get }
}

protocol RegisterViewModel: RegisterViewModelDelegate, RegisterViewModelInput, RegisterViewModelOutput {}

struct RegisterViewModelRequest {
}

final class RegisterViewModelImpl: RegisterViewModel {
    
  enum ViewModelError: Error {
  }
  
  enum Response {
      case error(ViewModelError)
  }

  weak var delegate: RegisterViewModelDelegate?
  let request: RegisterViewModelRequest
  
  // Output Setter
  @Published private var response: Response?
  
  // Output
  var responsePublisher: Published<RegisterViewModelImpl.Response?>.Publisher { $response }

  init(request: RegisterViewModelRequest) {
      self.request = request
  }

}

// MARK: Private Functions
private extension RegisterViewModelImpl {
    
}

// MARK: RegisterViewModel + RegisterViewModelInput
extension RegisterViewModelImpl {

  func viewDidLoad() {
  }

}

// MARK: RegisterViewModel + RegisterViewModelDelegate
extension RegisterViewModelImpl {
    
}

