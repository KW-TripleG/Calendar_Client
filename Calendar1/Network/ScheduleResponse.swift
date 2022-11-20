//
// Created by 앱등미니 on 2022/11/21.
//

import Foundation

struct ScheduleResponse: Codable {
	var status: Int
	var message: String
	var data: [ScheduleDataItem]

	enum CodingKeys: String, CodingKey {
		case status
		case message
		case data
	}
}

struct ScheduleDataItem: Codable {
	var scheduleId: Int
	var id: Int
	var title: String
	var content: String
	var startDate: String
	var endDate: String
	var duration: Int
	var userId: String
	var togetherId: String?
}

extension ScheduleDataItem {
	func asSchedule() -> Schedule {
		Schedule(id: scheduleId, title: title, content: content, userID: userId, togetherID: togetherId)
	}
}
