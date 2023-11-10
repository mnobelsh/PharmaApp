//
//  Encodable+Extension.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 10/11/23.
//

import Foundation

extension Encodable {
  
  func json() throws -> [String: Any] {
    let data = try self.data()
    let object = try JSONSerialization.jsonObject(with: data)
    if let json = object as? [String: Any]  { return json }
    let context = DecodingError.Context(
      codingPath: [],
      debugDescription: "Deserialized object is not a dictionary"
    )
    throw DecodingError.typeMismatch(type(of: object), context)
  }
  
  func data() throws -> Data {
    return try JSONEncoder().encode(self)
  }
  
}
