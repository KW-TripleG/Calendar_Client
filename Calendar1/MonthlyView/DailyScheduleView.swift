//
//  DailyScheduleView.swift
//  Calendar1
//
//  Created by Coldot on 2022/07/19.
//

import SwiftUI

struct DailyScheduleView: View {
    @EnvironmentObject var global: Global
    @State private var editSchedule: Schedule?

    var body: some View {
        let selectedSchedules = global.schedules.getSchedules(byYMDDate: global.selectedDate)
        
        VStack {
            Divider()

            if (selectedSchedules.count == 0) {
                Spacer()

                Text("이벤트 없음")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 22))
            } else {
                ScrollView {
                    ForEach(selectedSchedules, id: \.id) { element in
                        ScheduleItem(schedule: element).frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .onTapGesture {
                          self.editSchedule = element
                        }
                    }
                }
            }

            Spacer()
            Divider()
        }
        .sheet(item: $editSchedule) { schedule in
          EditScheduleView(schedule: schedule)
        }
    }
}

struct DailyScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        DailyScheduleView()
            .environmentObject(Global())
    }
}
