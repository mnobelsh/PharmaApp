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
  func didTapLogout()
}

protocol LaunchPadViewModelOutput {
  var state: Published<State?>.Publisher { get }
  var logoutState: Published<State?>.Publisher { get }
}

protocol LaunchPadViewModel: LaunchPadViewModelDelegate, LaunchPadViewModelInput, LaunchPadViewModelOutput {}

struct LaunchPadViewModelRequest {
}

final class LaunchPadViewModelImpl: LaunchPadViewModel {
    
  weak var delegate: LaunchPadViewModelDelegate?
  let request: LaunchPadViewModelRequest
  
  @Inject private var logoutUseCase: LogoutUseCase
  
  // Output Setter
  @Published private var stateValue: State?
  @Published private var logoutStateValue: State?
  
  // Output
  var state: Published<State?>.Publisher { $stateValue }
  var logoutState: Published<State?>.Publisher { $logoutStateValue }

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
  
  func didTapLogout() {
    logoutStateValue = .loading
    Task {
      do {
        try await logoutUseCase.execute(requestValue: .init())
        logoutStateValue = .success
      } catch let error as ErrorState {
        logoutStateValue = .error(error: error)
      }
    }
  }

}

// MARK: LaunchPadViewModel + LaunchPadViewModelDelegate
extension LaunchPadViewModelImpl {
    
}

