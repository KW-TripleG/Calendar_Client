//
//  RegisterScheduleResponse.swift
//  Calendar1
//
//  Created by woody on 2022/11/26.
//

import Foundation

struct RegisterScheduleResponse: Codable {
  let status: String
  let message: String
  
  enum CodingKeys: String, CodingKey {
    case status
    case message
  }
}
