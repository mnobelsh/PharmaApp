//
//  Data+Extension.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 10/11/23.
//

import Foundation

extension Data {
  
  func decode<T: Decodable>() -> T? {
    let decoder: JSONDecoder = JSONDecoder()
    return try? decoder.decode(T.self, from: self)
  }
  
}
