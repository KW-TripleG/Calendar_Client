//
//  SettingView.swift
//  Calendar1
//
//  Created by woody on 2022/11/26.
//

import SwiftUI

struct SettingView: View {
  @EnvironmentObject var global: Global
  @Environment(\.dismiss) private var dismiss
  @StateObject private var viewModel: SettingViewModel

  init(_ viewModel: SettingViewModel) {
    self._viewModel = .init(wrappedValue: viewModel)
  }

  var body: some View {
    NavigationView {
      Form {
        NavigationLink(destination: UserEditView(.init())) {
          let user = viewModel.user

          if let user {
            VStack(alignment: .leading) {
              if let nickName = user.nickName {
                Text(nickName).font(.title3)
              } else {
                Text(user.id)
              }

              Text(user.email).foregroundColor(.secondary)
            }
          } else {
            ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
          }
        }

        Section {
          Button {
            viewModel.signOut()
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
      .onAppear {
        viewModel.fetchUser()
      }
    }
  }
}
