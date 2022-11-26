//
// Created by 앱등미니 on 2022/09/24.
//

import Foundation

struct Schedule: Codable, Equatable {
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
