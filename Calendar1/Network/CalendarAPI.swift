//
//  CalendarAPI.swift
//  Calendar1
//
//  Created by woody on 2022/11/14.
//

import Foundation

enum HTTPMethod {
  case get
  case post
  case put
  
  var rawValue: String {
    switch self {
    case .get: return "GET"
    case .post: return "POST"
    case .put: return "PUT"
    }
  }
}

enum CalendarError: Error {
  case urlParse
  case nilUnWrapping
}

enum CalendarAPI {
  case login(id: String, password: String)
  case join(id: String, password: String, name: String, email: String)
  case registerSchedule(title: String, content: String, startDate: Date, endDate: Date)
  case getSchedule
  case updateSchedule(id: Int, title: String, content: String, startDate: Date, endDate: Date)
  
  var baseURL: String { "http://3.39.197.209:8080" }
  
  var path: String {
    switch self {
    case .login: return "/login"
    case .join: return "/join"
    case .registerSchedule: return "/schedule"
    case .getSchedule: return "/schedule"
    case .updateSchedule: return "/update-schedule"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .login: return .post
    case .join: return .post
    case .registerSchedule: return .put
    case .getSchedule: return .get
    case .updateSchedule: return .put
    }
  }
  
  var queryParameter: [String: String]? {
    return nil
  }
  
  var body: [String: Any]? {
    switch self {
    case .login(let id, let password):
      return [
        "id": id,
        "password": password
      ]
      
    case .join(let id, let password, let name, let email):
      return [
        "id": id,
        "password": password,
        "nickName": name,
        "email": email,
      ]
      
    case .registerSchedule(let title, let content, let startDate, let endDate):
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
      
      return [
        "title": title,
        "content": content,
        "startDate": dateFormatter.string(from: startDate),
        "endDate": dateFormatter.string(from: endDate),
        "duration": "0"
      ]
    
    case .updateSchedule(let id, let title, let content, let startDate, let endDate):
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
      
      return [
        "scheduleId": id,
        "title": title,
        "content": content,
        "startDate": dateFormatter.string(from: startDate),
        "endDate": dateFormatter.string(from: endDate),
        "duration": "0"
      ]
      
    default: return nil
    }
  }
}

extension CalendarAPI {
  func generateURLRequest() throws -> URLRequest {
    guard var urlComponent = URLComponents(string: self.baseURL + self.path) else {
      throw CalendarError.urlParse
    }
    
    if let queryParameter {
      urlComponent.queryItems = queryParameter.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
    guard let url = urlComponent.url else { throw CalendarError.nilUnWrapping }
    
    var request = URLRequest(url: url)
    request.httpMethod = self.method.rawValue
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    if let jwt = UserDefaults.standard.string(forKey: "jwt") {
      request.setValue(jwt, forHTTPHeaderField: "X-AUTH-TOKEN")
    }
    
    if let body  {
      request.httpBody = try? JSONSerialization.data(withJSONObject: body)
    }
    
    return request
  }
}

extension CalendarAPI {
  var mock: Data {
    switch self {
    case .login:
      return Data(
        """
        {
          "status" : 200,
          "message" : "로그인 성공"
        }
        """.utf8
      )
    case .join:
      return Data(
        """
        {
          "data" : "test",
          "status" : 200,
          "message" : "회원가입 성공"
        }
        """.utf8
      )
      
    default: return Data()
    }
  }
}
