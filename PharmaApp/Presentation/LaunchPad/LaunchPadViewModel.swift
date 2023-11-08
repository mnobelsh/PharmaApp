//
//  LaunchPadViewModel.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 08/11/23.
//  Copyright (c) 2023 All rights reserved.
//

import Foundation

protocol LaunchPadViewModelDelegate: AnyObject {
}

protocol LaunchPadViewModelInput {
  func viewDidLoad()
}

protocol LaunchPadViewModelOutput {
  var responsePublisher: Published<LaunchPadViewModelImpl.Response?>.Publisher { get }
}

protocol LaunchPadViewModel: LaunchPadViewModelDelegate, LaunchPadViewModelInput, LaunchPadViewModelOutput {}

struct LaunchPadViewModelRequest {
}

final class LaunchPadViewModelImpl: LaunchPadViewModel {
    
  enum ViewModelError: Error {
  }
  
  enum Response {
      case error(ViewModelError)
  }

  weak var delegate: LaunchPadViewModelDelegate?
  let request: LaunchPadViewModelRequest
  
  // Output Setter
  @Published private var response: Response?
  
  // Output
  var responsePublisher: Published<LaunchPadViewModelImpl.Response?>.Publisher { $response }

  init(request: LaunchPadViewModelRequest) {
      self.request = request
  }

}

// MARK: Private Functions
private extension LaunchPadViewModelImpl {
    
}

// MARK: LaunchPadViewModel + LaunchPadViewModelInput
extension LaunchPadViewModelImpl {

  func viewDidLoad() {
  }

}

// MARK: LaunchPadViewModel + LaunchPadViewModelDelegate
extension LaunchPadViewModelImpl {
    
}

