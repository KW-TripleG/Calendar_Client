//
//  CalendarHelper.swift
//  Calendar1
//
//  Created by Coldot on 2022/07/19.
//

import Foundation

class CalendarHelper {
    
    let calendar = Calendar.current
    let dateFormat = DateFormatter()
    
    func getYearMonthStr(_ date: Date) -> String {
        dateFormat.dateFormat = "yyyy년 M월"
        return dateFormat.string(from: date)
    }
    
    func getDaysInMonth(_ date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    func getDayOfMonth(_ date: Date) -> Int {
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
        let daysInMonth = getDaysInMonth(date)
        let days = Array(1...daysInMonth).filter {
            ($0 + (firstWeekday - 1)) % 7 == 0          // saturday
            || ($0 + (firstWeekday - 2)) % 7 == 0       // sunday
        }
        
        return days
    }
    
}
