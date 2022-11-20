//
//  CalendarHelper.swift
//  Calendar1
//
//  Created by Coldot on 2022/07/19.
//

import Foundation

class CalendarHelper {
    
    private static let calendar = Calendar.current
    private static let monthDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        return formatter
    }()

    private static let dateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()

    static func parseDateTime(_ str: String) -> Date? {
        dateTimeFormatter.date(from: str)
    }
    
    static func getYearMonthStr(_ date: Date) -> String {
        monthDateFormatter.string(from: date)
    }
    
    static func getDaysInMonth(_ date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    static func getDayOfMonth(_ date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    static func getFirstOfMonth(_ date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    static func getWeekday(_ date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday!
    }
    
    static func getFirstWeekdayOfMonth(_ date: Date) -> Int {
        let firstOfMonth = getFirstOfMonth(date)
        return getWeekday(firstOfMonth)
    }
    
    static func getWeekendDaysInMonth(_ date: Date) -> [Int] {
        let firstWeekday = getFirstWeekdayOfMonth(date)
        let daysInMonth = getDaysInMonth(date)
        let days = Array(1...daysInMonth).filter {
            ($0 + (firstWeekday - 1)) % 7 == 0          // saturday
            || ($0 + (firstWeekday - 2)) % 7 == 0       // sunday
        }
        
        return days
    }
    
    static func getDatesOfMonth(_ date: Date) -> [Date] {
        let monthComp = calendar.dateComponents([.year, .month], from: date)
        let monthDate = calendar.date(from: monthComp)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        let dates = range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day, to: monthDate)!
        }
        
        return dates
    }
    
    static func getMonthAdding(_ value: Int, to: Date) -> Date {
        return calendar.date(byAdding: .month, value: value, to: to)!
    }
}
