//
//  AppState.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 10/11/23.
//

import Foundation
import KeychainAccess

final class AppState {
  
  static let shared: AppState = AppState()
  
  private let keychain: Keychain
  
  private init() {
    self.keychain = Keychain()
  }
  
  // ACCESS TOKEN
  func setAccessToken(_ token: String?) throws {
    try keychain.set(token ?? "", key: Constant.AppState.accessToken)
  }
  func getAccessToken() -> String? {
    guard let token = try? keychain.get(Constant.AppState.accessToken) else {
      return nil
    }
    return token
  }
  
}
