//
//  SettingView.swift
//  Calendar1
//
//  Created by woody on 2022/11/26.
//

import SwiftUI

struct SettingView: View {
  @EnvironmentObject var globalRouter: GlobalRouter
  @EnvironmentObject var global: Global
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    NavigationView {
      Form {
        Section {
          Button {
            UserDefaults.standard.set(nil, forKey: "jwt")
            self.global.clear()
            self.globalRouter.screen = .signIn
          } label: {
            Text("로그아웃")
              .foregroundColor(.red)
          }
        }
      }
      .navigationBarTitle("설정", displayMode: .inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button("취소") {
            self.dismiss()
          }
        }
      }
    }
  }
}
