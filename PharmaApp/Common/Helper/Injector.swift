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
  
  private let name: String?
  
  var wrappedValue: T {
    get {
      let resolved = AppDIContainer.shared.container.resolve(T.self, name: name)
      assert(resolved != nil, "Dependency not found: \(String(describing: T.self)) \(String(describing: name))")
      return resolved!
    }
  }
  
  init(name: String) {
    self.name = name
  }
  
}
