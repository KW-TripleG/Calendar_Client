//
//  LoginResponse.swift
//  Calendar1
//
//  Created by woody on 2022/11/14.
//

import Foundation

struct LoginResponse: Codable {
  let status: String
  let message: String
  let jwt: String?
  
  enum CodingKeys: String, CodingKey {
    case status
    case message
    case jwt = "data"
  }
}
