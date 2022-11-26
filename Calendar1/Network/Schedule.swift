//
// Created by 앱등미니 on 2022/09/24.
//

import Foundation

struct Schedule: Codable, Equatable, Identifiable {
  var id: Int
  var title: String
  var content: String
  var startDate: Date
  var endDate: Date
  
  enum CodingKeys: String, CodingKey {
    case id = "scheduleId"
    case title
    case content
    case startDate
    case endDate
  }
  
  enum Title {
    case allDay(title: String)
    case limitDay(startTitle: String?, endTitle: String?)
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try values.decode(Int.self, forKey: .id)
    self.title = try values.decode(String.self, forKey: .title)
    self.content = try values.decode(String.self, forKey: .content)
    
    let startDate = try values.decode(String.self, forKey: .startDate)
    let endDate = try values.decode(String.self, forKey: .endDate)
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    
    self.startDate = dateFormatter.date(from: startDate) ?? Date()
    self.endDate = dateFormatter.date(from: endDate) ?? Date()
  }
  
  func getTitle(selectedDate: Date) -> Title {
    let startDate = selectedDate.dateWithOutTime
    let nextDate = CalendarHelper.getDayAdding(1, to: startDate)
    let endDate = CalendarHelper.getMinAdding(-1, to: nextDate)
    
    let isAllDay = self.startDate <= startDate && self.endDate >= endDate
    
    if isAllDay {
      return .allDay(title: "하루 종일")
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "a h:mm"
    
    let startTitle: String? = self.startDate <= startDate
    ? nil
    : dateFormatter.string(from: self.startDate)
    let endTitle = self.endDate >= endDate
    ? nil
    : dateFormatter.string(from: self.endDate)
    
    return .limitDay(startTitle: startTitle, endTitle: endTitle)
  }
}

typealias Schedules = Array<Schedule>

extension Schedules {
  func getSchedules(byYMDDate date: Date) -> Schedules {
    let schedules = self.filter { schedule -> Bool in
      CalendarHelper.isDateInRange(date, from: schedule.startDate, to: schedule.endDate)
    }
    
    return schedules
  }
}
