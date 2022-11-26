//
//  JoinResponse.swift
//  Calendar1
//
//  Created by Coldot on 2022/11/20.
//

import Foundation

struct JoinResponse: Codable {
  let status: String
  let message: String
  let jwt: String?
  
  enum CodingKeys: String, CodingKey {
    case status
    case message
    case jwt = "data"
  }
}
