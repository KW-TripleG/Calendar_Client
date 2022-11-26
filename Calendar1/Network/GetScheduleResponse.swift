//
//  GetScheduleResponse.swift
//  Calendar1
//
//  Created by woody on 2022/11/26.
//

import Foundation

struct GetScheduleResponse: Codable {
  let status: String
  let message: String
  let data: [Schedule]
}
