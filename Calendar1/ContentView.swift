//
//  ContentView.swift
//  Calendar1
//
//  Created by Coldot on 2022/07/18.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject private var globalRounter: GlobalRouter
    
    var body: some View {
      switch globalRounter.screen {
      case .auth:
        AuthView(viewModel: .init(globalRouter: self.globalRounter))
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
