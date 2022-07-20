//
//  DailyScheduleView.swift
//  Calendar1
//
//  Created by Coldot on 2022/07/19.
//

import SwiftUI

struct DailyScheduleView: View {
    var body: some View {
        VStack {
            Divider()

//            Text("DailyScheduleView")
            
            Spacer()
            
            Text("이벤트 없음")
                .foregroundColor(Color.gray)
                .font(.system(size: 22))
            
            Spacer()
        }
    }
}

struct DailyScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        DailyScheduleView()
    }
}
