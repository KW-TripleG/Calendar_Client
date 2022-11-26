//
//  SettingView.swift
//  Calendar1
//
//  Created by woody on 2022/11/26.
//

import SwiftUI

struct SettingView: View {
  @EnvironmentObject var globalRouter: GlobalRouter
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    NavigationView {
      Form {
        Section {
          Button {
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
