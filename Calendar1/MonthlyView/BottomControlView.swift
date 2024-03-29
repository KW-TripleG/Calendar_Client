//
//  BottomControlView.swift
//  Calendar1
//
//  Created by Coldot on 2022/07/19.
//

import SwiftUI

struct BottomControlView: View {
    @State private var isPresentedSetting: Bool = false
    @EnvironmentObject private var global: Global
    @EnvironmentObject private var globalRouter: GlobalRouter

    var body: some View {
        HStack {
            Button("설정") {
              self.isPresentedSetting = true
            }
            Spacer()
            Button("캘린더") {}
            Spacer()
            Button("초대") {}
        }.padding()
        .sheet(isPresented: $isPresentedSetting) {
          SettingView(.init(global, globalRouter))
        }
    }
}

struct BottomControlView_Previews: PreviewProvider {
    static var previews: some View {
        BottomControlView()
    }
}
