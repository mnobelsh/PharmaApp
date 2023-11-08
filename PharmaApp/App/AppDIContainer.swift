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
    
  }
  
}
