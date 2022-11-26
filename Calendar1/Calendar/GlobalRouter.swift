//
//  GlobalRouter.swift
//  Calendar1
//
//  Created by woody on 2022/11/14.
//

import Foundation

enum Screen {
  case signIn
  case signUp
  case calendar
}

final class GlobalRouter: ObservableObject {
  @Published var screen: Screen
  
  init() {
    if UserDefaults.standard.string(forKey: "jwt") != nil {
      self.screen = .calendar
    } else {
      self.screen = .signIn
    }
  }
}
