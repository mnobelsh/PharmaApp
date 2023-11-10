//
//  AppDIContainer.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 07/11/23.
//

import Foundation
import Swinject

final class AppDIContainer {
  
  static let shared: AppDIContainer = AppDIContainer()
  var container: Container
  
  private init() {
    self.container = Container()
  }
  
  func register() {
    container.register(APIService.self) { r in APIServiceImpl() }
    container.register(AuthenticationRepository.self) { r in
      AuthenticationRepositoryImpl(apiService: r.resolve(APIService.self)!)
    }
    container.register(LoginUseCase.self) { r in
      LoginUseCase(authRepository: r.resolve(AuthenticationRepository.self)!)
    }
    container.register(LogoutUseCase.self) { r in
      LogoutUseCase(authRepository: r.resolve(AuthenticationRepository.self)!)
    }
  }
  
}
