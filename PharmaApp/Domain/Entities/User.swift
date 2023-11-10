//
//  User.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 10/11/23.
//

import Foundation

struct User: Equatable, Identifiable {
  var id: Int
  var email: String
  var firstName: String?
  var lastName: String?
  var avatar: String?
}
