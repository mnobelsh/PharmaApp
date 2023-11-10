//
//  AuthenticationRepository.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 10/11/23.
//

import Foundation

protocol AuthenticationRepository {
  
  func login(request: LoginRequestDTO) async throws -> LoginResponseDTO?
  func register()
  func logout() async throws
  
}
