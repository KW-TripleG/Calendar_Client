//
//  CalendarHelper.swift
//  Calendar1
//
//  Created by Coldot on 2022/07/19.
//

import Foundation

class CalendarHelper {
    
    private var calendar: Calendar
    private let dateFormat: DateFormatter
    
    init() {
        self.calendar = Calendar.current
        self.dateFormat = DateFormatter()
        calendar.timeZone = TimeZone(abbreviation: "KST")!
    }
    
    func getYearMonthStr(_ date: Date) -> String {
        dateFormat.dateFormat = "yyyy년 M월"
        return dateFormat.string(from: date)
    }
    
    func getDate(year: Int?, month: Int?, day: Int?, hour: Int?, minute: Int?) -> Date? {
        let components = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute)
        let date = calendar.date(from: components)
        return date
    }
    
    func getNumOfDaysInMonth(_ date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    func getDay(_ date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    func getFirstOfMonth(_ date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    func getWeekday(_ date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday!
    }
    
    func getFirstWeekdayOfMonth(_ date: Date) -> Int {
        let firstOfMonth = getFirstOfMonth(date)
        return getWeekday(firstOfMonth)
    }
    
    func getWeekendDaysInMonth(_ date: Date) -> [Int] {
        let firstWeekday = getFirstWeekdayOfMonth(date)
        let daysInMonth = getNumOfDaysInMonth(date)
        let days = Array(1...daysInMonth).filter {
            ($0 + (firstWeekday - 1)) % 7 == 0          // saturday
            || ($0 + (firstWeekday - 2)) % 7 == 0       // sunday
        }
        
        return days
    }
    
    func getDatesOfMonth(_ date: Date) -> [Date] {
        let monthComp = calendar.dateComponents([.year, .month], from: date)
        let monthDate = calendar.date(from: monthComp)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        let dates = range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: monthDate)!
        }
        
        return dates
    }
    
    func getMonthAdding(_ value: Int, to: Date) -> Date {
        return calendar.date(byAdding: .month, value: value, to: to)!
    }
    
    func isSameYearMonth(_ month: Date, withDate: Date) -> Bool {
        let isSame = (calendar.isDate(month, equalTo: withDate, toGranularity: .year)
                     && calendar.isDate(month, equalTo: withDate, toGranularity: .month))
        return isSame
    }
    
    func isSameYearMonthDay(_ month: Date, withDate: Date) -> Bool {
        let isSame = (calendar.isDate(month, equalTo: withDate, toGranularity: .year)
                      && calendar.isDate(month, equalTo: withDate, toGranularity: .month)
                      && calendar.isDate(month, equalTo: withDate, toGranularity: .day))
        return isSame
    }
    
    func isDateInRange(_ date: Date, from: Date, to: Date) -> Bool {
        let fromComp = calendar.dateComponents([.year, .month, .day], from: from)
        let toComp = calendar.dateComponents([.year, .month, .day], from: to)
        let fromYMD = calendar.date(from: fromComp)!
        let toYMD = calendar.date(from: toComp)!

        return (fromYMD <= date) && (date <= toYMD)
    }
    
    func isCurrentMonth(_ month: Date) -> Bool {
        let currentDate = Date()
        return isSameYearMonth(month, withDate: currentDate)
    }
}
