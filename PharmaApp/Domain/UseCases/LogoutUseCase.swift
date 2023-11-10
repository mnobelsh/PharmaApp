//
//  LogoutUseCase.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 10/11/23.
//

import Foundation

final class LogoutUseCase {
  
  struct RequestValue {
  }
  
  private let authRepository: AuthenticationRepository
  
  init(authRepository: AuthenticationRepository) {
    self.authRepository = authRepository
  }
  
  func execute(requestValue: RequestValue) async throws {
    try await authRepository.logout()
  }
  
}
