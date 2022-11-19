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
  
  var rawValue: String {
    switch self {
    case .get: return "GET"
    case .post: return "POST"
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
  
  var baseURL: String { "???" }
  
  var path: String {
    switch self {
    case .login: return "/login"
    case .join: return "/join"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .login: return .get
    case .join: return .post
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
                "name": name,
                "email": email,
            ]
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
    }
  }
}
