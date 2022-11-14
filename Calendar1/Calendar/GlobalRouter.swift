//
//  GlobalRouter.swift
//  Calendar1
//
//  Created by woody on 2022/11/14.
//

import Foundation

enum Screen {
  case auth
  case calendar
}

final class GlobalRouter: ObservableObject {
  @Published var screen: Screen = .auth
}
