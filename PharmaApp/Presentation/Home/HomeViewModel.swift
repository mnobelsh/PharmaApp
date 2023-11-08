//
//  HomeViewModel.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 08/11/23.
//  Copyright (c) 2023 All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
}

protocol HomeViewModelInput {
  func viewDidLoad()
}

protocol HomeViewModelOutput {
  var responsePublisher: Published<HomeViewModelImpl.Response?>.Publisher { get }
}

protocol HomeViewModel: HomeViewModelDelegate, HomeViewModelInput, HomeViewModelOutput {}

struct HomeViewModelRequest {
}

final class HomeViewModelImpl: HomeViewModel {
    
  enum ViewModelError: Error {
  }
  
  enum Response {
      case error(ViewModelError)
  }

  weak var delegate: HomeViewModelDelegate?
  let request: HomeViewModelRequest
  
  // Output Setter
  @Published private var response: Response?
  
  // Output
  var responsePublisher: Published<HomeViewModelImpl.Response?>.Publisher { $response }

  init(request: HomeViewModelRequest) {
    self.request = request
  }

}

// MARK: Private Functions
private extension HomeViewModelImpl {
    
}

// MARK: HomeViewModel + HomeViewModelInput
extension HomeViewModelImpl {

  func viewDidLoad() {
  }

}

// MARK: HomeViewModel + HomeViewModelDelegate
extension HomeViewModelImpl {
    
}

