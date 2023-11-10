//
//  UserResponseDTO.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 10/11/23.
//

import Foundation

struct GetSingleUserDTO: Decodable {
  var data: UserResponseDTO
}

struct UserResponseDTO: Decodable {
  var id: Int
  var email: String
  var first_name: String?
  var last_name: String?
  var avatar: String?
}

extension UserResponseDTO {
  
  func toDomain() -> User {
    return User(id: id, email: email, firstName: first_name, lastName: last_name, avatar: avatar)
  }
  
}
