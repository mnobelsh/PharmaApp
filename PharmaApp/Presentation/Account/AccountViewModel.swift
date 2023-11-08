//
//  AccountViewModel.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 08/11/23.
//  Copyright (c) 2023 All rights reserved.
//

import Foundation

protocol AccountViewModelDelegate: AnyObject {
}

protocol AccountViewModelInput {
    func viewDidLoad()
}

protocol AccountViewModelOutput {
    var responsePublisher: Published<AccountViewModelImpl.Response?>.Publisher { get }
}

protocol AccountViewModel: AccountViewModelDelegate, AccountViewModelInput, AccountViewModelOutput {}

struct AccountViewModelRequest {
}

final class AccountViewModelImpl: AccountViewModel {
    
  enum ViewModelError: Error {
  }
  
  enum Response {
    case error(ViewModelError)
  }

  weak var delegate: AccountViewModelDelegate?
  let request: AccountViewModelRequest
  
  // Output Setter
  @Published private var response: Response?
  
  // Output
  var responsePublisher: Published<AccountViewModelImpl.Response?>.Publisher { $response }

  init(request: AccountViewModelRequest) {
    self.request = request
  }

}

// MARK: Private Functions
private extension AccountViewModelImpl {
    
}

// MARK: AccountViewModel + AccountViewModelInput
extension AccountViewModelImpl {

  func viewDidLoad() {
  }

}

// MARK: AccountViewModel + AccountViewModelDelegate
extension AccountViewModelImpl {
    
}

