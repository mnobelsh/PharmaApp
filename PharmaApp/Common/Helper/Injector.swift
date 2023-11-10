//
//  Injector.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 07/11/23.
//

import Foundation
import Swinject

@propertyWrapper
struct Inject<T> {
  private var component: T
  
  init(factoryName name: String? = nil) {
    self.component = AppDIContainer.shared.container.resolve(T.self, name: name)!
  }
  
  public var wrappedValue: T {
      get { return component}
      mutating set { component = newValue }
  }
}
