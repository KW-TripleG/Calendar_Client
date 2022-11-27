//
// Created by 앱등미니 on 2022/09/24.
//

import Foundation
import SwiftUI

struct ScheduleItem: View {
  @EnvironmentObject var global: Global
  let schedule: Schedule
    
  init(schedule: Schedule) {
    self.schedule = schedule
  }

	var body: some View {
		HStack(spacing: 8) {
			Spacer().frame(width: 6, height: 21).background(Color.red).clipShape(Capsule())
			Text(schedule.title)

			// TODO: add duration field to [Schedule]
			Spacer()
      let title = schedule.getTitle(selectedDate: self.global.selectedDate)
      
      VStack {
        switch title {
        case .allDay(let title):
          Text(title)
            .fontWeight(.light)
        case .limitDay(let startTitle, let endTitle):
          if let startTitle {
            Text(startTitle)
              .font(.system(.footnote, design: .monospaced))
          }
          
          if let endTitle {
            Text(endTitle)
              .font(.system(.footnote, design: .monospaced))
              .foregroundColor(Color.gray)
          }
        }
      }
		}
    .padding(.vertical, 8).padding(.horizontal, 16)
    .frame(height: 30)
	}
}
