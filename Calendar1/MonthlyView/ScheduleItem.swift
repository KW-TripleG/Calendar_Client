//
// Created by 앱등미니 on 2022/09/24.
//

import Foundation
import SwiftUI

struct ScheduleItem: View {
	@Binding var schedule: Schedule

	var body: some View {
		HStack(spacing: 8) {
			Spacer().frame(width: 6, height: 21).background(Color.red).clipShape(Capsule())
			Text(schedule.title)

			// TODO: add duration field to [Schedule]
			Spacer()
			Text("하루 종일").foregroundColor(Color(UIColor.secondaryLabel))
		}.padding(.vertical, 8).padding(.horizontal, 16)
	}
}
