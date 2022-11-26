//
//  Promise.swift
//  Calendar1
//
//  Created by woody on 2022/11/14.
//

import Foundation

final class Promise {
  static let shared = Promise()
  
  private let isUseMock: Bool = false
  
  private init() { }
  
  func request<Model: Decodable>(_ calendarAPI: CalendarAPI) async throws -> Model  {
    let responseData: Data
    
    if isUseMock {
      responseData = calendarAPI.mock
    } else {
      let (data, _) = try await URLSession.shared.data(for: calendarAPI.generateURLRequest())
      responseData = data
    }
    
    print("Response -> ", String(data: responseData, encoding: .utf8) ?? "")

    return try JSONDecoder().decode(Model.self, from: responseData)
  }
}
