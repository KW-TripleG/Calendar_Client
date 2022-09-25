//
//  DailyScheduleView.swift
//  Calendar1
//
//  Created by Coldot on 2022/07/19.
//

import SwiftUI

struct DailyScheduleView: View {
    @Binding var schedules: Array<Schedule>

    var body: some View {
        VStack {
            Divider()

            if (schedules.count == 0) {
                Spacer()

                Text("이벤트 없음")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 22))
            } else {
                ForEach($schedules, id: \.id) { element in
                    ScheduleItem(schedule: element).frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
            }

            Spacer()
            Divider()
        }
    }
}

struct DailyScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        DailyScheduleView(schedules: .constant([]))
    }
}
