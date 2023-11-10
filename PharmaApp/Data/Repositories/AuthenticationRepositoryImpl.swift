//
//  AuthenticationRepositoryImpl.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 10/11/23.
//

import Foundation

final class AuthenticationRepositoryImpl: AuthenticationRepository {
  
  private let apiService: APIService
  private var baseUrl: String {
    guard let url = Bundle.main.object(forInfoDictionaryKey: "AUTH_BASE_URL") as? String else {
      fatalError("Unable to find AUTH_BASE_URL")
    }
    return url
  }
  
  init(apiService: APIService) {
    self.apiService = apiService
  }
  
  func login(request: LoginRequestDTO) async throws -> LoginResponseDTO? {
    let response: LoginResponseDTO? = try await apiService.post(to: baseUrl + "login", body: request.json())
    try AppState.shared.setAccessToken(response?.token)
    return response
  }
  
  func register() {
    
  }
  
  func logout() async throws {
    try await apiService.post(to: baseUrl + "logout", body: nil)
    try AppState.shared.setAccessToken(nil)
  }
  
}
