//
// Created by 앱등미니 on 2022/09/24.
//

import Foundation

struct Schedule {
	var id: Int
	var title: String
	var content: String?
    var startDate: Date
    var endDate: Date
	var userID: String
	var togetherID: String?

    init(id: Int, title: String, content: String?, startDate: Date, endDate: Date, userID: String, togetherID: String?) {
		self.id = id
		self.title = title
		self.content = content
        self.startDate = startDate
        self.endDate = endDate
		self.userID = userID
		self.togetherID = togetherID
	}
}


typealias Schedules = Array<Schedule>

extension Schedules {
    func getSchedules(byYMDDate date: Date) -> Schedules {
        let calendarHelper = CalendarHelper()
        let schedules = self.filter { schedule -> Bool in
            calendarHelper.isDateInRange(date, from: schedule.startDate, to: schedule.endDate)
        }
        
        return schedules
    }
}
