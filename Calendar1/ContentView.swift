//
//  ContentView.swift
//  Calendar1
//
//  Created by Coldot on 2022/07/18.
//

import SwiftUI


struct ContentView: View {
  @EnvironmentObject private var globalRounter: GlobalRouter
  
  init() {
    UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor.systemRed
  }
  
  var body: some View {
    switch globalRounter.screen {
    case .signUp:
      SignUpView(.init(globalRouter: self.globalRounter))
    case .signIn:
      SignInView(.init(globalRouter: self.globalRounter))
    case .calendar:
      MonthlyView()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(GlobalRouter())
  }
}
