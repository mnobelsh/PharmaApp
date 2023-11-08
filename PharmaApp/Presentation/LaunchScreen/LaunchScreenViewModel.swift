//
//  LaunchScreenViewModel.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 07/11/23.
//  Copyright (c) 2023 All rights reserved.
//

import Foundation

protocol LaunchScreenViewModelDelegate: AnyObject {
}

protocol LaunchScreenViewModelInput {
  func viewDidLoad()
}

protocol LaunchScreenViewModelOutput {
  var responsePublisher: Published<LaunchScreenViewModelImpl.Response?>.Publisher { get }
}

protocol LaunchScreenViewModel: LaunchScreenViewModelDelegate, LaunchScreenViewModelInput, LaunchScreenViewModelOutput {}

struct LaunchScreenViewModelRequest {
}

final class LaunchScreenViewModelImpl: LaunchScreenViewModel {
    
  enum ViewModelError: Error {
  }
  
  enum Response {
    case error(ViewModelError)
  }

  weak var delegate: LaunchScreenViewModelDelegate?
  let request: LaunchScreenViewModelRequest
  
  // Output Setter
  @Published private var response: Response?
  
  // Output
  var responsePublisher: Published<LaunchScreenViewModelImpl.Response?>.Publisher { $response }

  init(request: LaunchScreenViewModelRequest) {
    self.request = request
  }

}

// MARK: Private Functions
private extension LaunchScreenViewModelImpl {
    
}

// MARK: LaunchScreenViewModel + LaunchScreenViewModelInput
extension LaunchScreenViewModelImpl {

  func viewDidLoad() {
  }

}

// MARK: LaunchScreenViewModel + LaunchScreenViewModelDelegate
extension LaunchScreenViewModelImpl {
    
}

