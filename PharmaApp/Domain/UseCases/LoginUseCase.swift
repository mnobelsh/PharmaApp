//
//  LoginUseCase.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 10/11/23.
//

import Foundation

final class LoginUseCase {
  
  struct RequestValue {
    var email: String
    var password: String
  }
  
  private let authRepository: AuthenticationRepository
  
  init(authRepository: AuthenticationRepository) {
    self.authRepository = authRepository
  }
  
  @discardableResult
  func execute(requestValue: RequestValue) async throws -> String {
    guard let response: LoginResponseDTO = try await authRepository.login(request: .init(email: requestValue.email, password: requestValue.password)) else {
      throw ErrorState.client
    }
    return response.token
  }
  
}
