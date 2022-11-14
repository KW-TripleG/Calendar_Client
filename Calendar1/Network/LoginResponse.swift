//
//  LoginResponse.swift
//  Calendar1
//
//  Created by woody on 2022/11/14.
//

import Foundation

struct LoginResponse: Codable {
  let status: Int
  let message: String
  
  enum CodingKeys: String, CodingKey {
    case status
    case message
  }
}
