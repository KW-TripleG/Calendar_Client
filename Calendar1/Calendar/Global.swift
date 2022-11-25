//
//  Global.swift
//  Calendar1
//
//  Created by Coldot on 2022/11/21.
//

import Foundation


final class Global: ObservableObject {
    
    @Published var selectedDate: Date
    @Published var schedules: Schedules
    
    private let useMockSchedules: Bool = true
    
    init() {
        self.selectedDate = Date()
        self.schedules = []
        
        if useMockSchedules {
            self.setMockSchedules()
        }
    }
    
    init(schedules: Schedules) {
        self.selectedDate = Date()
        self.schedules = schedules
    }
}


extension Global {
    private func setMockSchedules() {
        let calendarHelper = CalendarHelper()
        let date1: Date = calendarHelper.getDate(year: 2022, month: 11, day: 21, hour: 12, minute: 00)!
        let date2: Date = calendarHelper.getDate(year: 2022, month: 11, day: 21, hour: 14, minute: 30)!
        let date3: Date = calendarHelper.getDate(year: 2022, month: 12, day: 10, hour: 08, minute: 00)!
        let date4: Date = calendarHelper.getDate(year: 2022, month: 12, day: 10, hour: 10, minute: 15)!
        
        self.schedules = [
            Schedule(id: 0, title: "asdf", content: nil, startDate: date1, endDate: date2, userID: "", togetherID: nil),
            Schedule(id: 1, title: "foo", content: nil, startDate: date1, endDate: date2, userID: "", togetherID: nil),
            Schedule(id: 2, title: "bar", content: nil, startDate: date1, endDate: date2, userID: "", togetherID: nil),
            Schedule(id: 3, title: "qaz", content: nil, startDate: date1, endDate: date2, userID: "", togetherID: nil),
            Schedule(id: 4, title: "qax", content: nil, startDate: date1, endDate: date2, userID: "", togetherID: nil),
            Schedule(id: 5, title: "lorem", content: nil, startDate: date1, endDate: date2, userID: "", togetherID: nil),
            Schedule(id: 6, title: "ipsum", content: nil, startDate: date1, endDate: date2, userID: "", togetherID: nil),
            Schedule(id: 7, title: "dolor", content: nil, startDate: date3, endDate: date4, userID: "", togetherID: nil),
            Schedule(id: 8, title: "sit", content: nil, startDate: date3, endDate: date4, userID: "", togetherID: nil),
            Schedule(id: 9, title: "amet", content: nil, startDate: date3, endDate: date4, userID: "", togetherID: nil),
            Schedule(id: 10, title: "abc", content: nil, startDate: date3, endDate: date4, userID: "", togetherID: nil),
            Schedule(id: 11, title: "def", content: nil, startDate: date3, endDate: date4, userID: "", togetherID: nil),
            Schedule(id: 12, title: "ghi", content: nil, startDate: date3, endDate: date4, userID: "", togetherID: nil),
            Schedule(id: 13, title: "jkl", content: nil, startDate: date3, endDate: date4, userID: "", togetherID: nil),
            Schedule(id: 14, title: "mno", content: nil, startDate: date3, endDate: date4, userID: "", togetherID: nil),
        ]
    }
}
