//
//  State.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 10/11/23.
//

import Foundation

enum State {
  case loading
  case reloading
  case success
  case error(error: ErrorState)
}

enum ErrorState: Error {
  case backend(description: String?)
  case requestTimout
  case unauthorized
  case client
  case unknown
  case uiError(description: String?)
}
