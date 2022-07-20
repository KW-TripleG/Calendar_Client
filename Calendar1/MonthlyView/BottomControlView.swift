//
//  BottomControlView.swift
//  Calendar1
//
//  Created by Coldot on 2022/07/19.
//

import SwiftUI

struct BottomControlView: View {
    var body: some View {
        HStack {
            Button("오늘") {}
            Spacer()
            Button("캘린더") {}
            Spacer()
            Button("초대") {}
        }.padding()
    }
}

struct BottomControlView_Previews: PreviewProvider {
    static var previews: some View {
        BottomControlView()
    }
}
