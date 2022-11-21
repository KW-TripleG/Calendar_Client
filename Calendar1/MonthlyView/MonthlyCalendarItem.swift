//
//  MonthlyCalendarItem.swift
//  Calendar1
//
//  Created by Coldot on 2022/07/19.
//

import SwiftUI

// TODO: MonthlyCalendarItem도 ViewModel과 함께 리팩토링 (이름 변경 및 코드 정리도 필요)
struct MonthlyCalendarItem: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    let calendarHelper: CalendarHelper
    
    let month: Date
    let currentDate: Date
    let isCurrentMonth: Bool
    
    let todayDay: Int
    let daysInMonth: Int
    let weekends: [String]
    let datesOfMonth: [Date]
    let daysOfMonth: [String]
    let datesAndDaysOfMonth: [(Date, String)]
    let firstWeekday: Int
    let cols: [GridItem]
    
    init(month: Date) {
        self.calendarHelper = CalendarHelper()
        
        self.month = month
        self.currentDate = Date()
        self.isCurrentMonth = calendarHelper.isCurrentMonth(month)

        self.todayDay = calendarHelper.getDayOfMonth(currentDate)
        self.daysInMonth = calendarHelper.getDaysInMonth(month)
        self.weekends = calendarHelper.getWeekendDaysInMonth(month).map {"\($0)"}
        self.datesOfMonth = calendarHelper.getDatesOfMonth(month)
        self.daysOfMonth = Array(1...daysInMonth).map {"\($0)"}
        self.datesAndDaysOfMonth = Array(zip(datesOfMonth, daysOfMonth))
        self.firstWeekday = calendarHelper.getFirstWeekdayOfMonth(month)

        self.cols = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)
    }
    
    
    var body: some View {
//        let calendarHelper = CalendarHelper()
        let isSelectedMonth = calendarHelper.isSameMonth(dateHolder.selected, withDate: month)
        let selectedDay = calendarHelper.getDayOfMonth(dateHolder.selected)
//
//        let isCurrentMonth = calendarHelper.isCurrentMonth(month)
//        let todayDay = calendarHelper.getDayOfMonth(currentDate)
        
//        let daysInMonth = calendarHelper.getDaysInMonth(month)
//        let weekends = calendarHelper.getWeekendDaysInMonth(month).map {"\($0)"}
//        let datesOfMonth = calendarHelper.getDatesOfMonth(month)
//        let daysOfMonth = Array(1...daysInMonth).map {"\($0)"}
//        let datesAndDaysOfMonth = Array(zip(datesOfMonth, daysOfMonth))
//        let firstWeekday = calendarHelper.getFirstWeekdayOfMonth(month)
//
//        let cols = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)

        LazyVGrid(columns: cols, spacing: 0) {
            
            // blank
            let blanks = Array<Int>(1..<firstWeekday)
            ForEach(blanks, id: \.self) { n in
                VStack {
                    Divider()
                    
                    Text("\(n)")
                        .foregroundColor(Color.clear)
                        .padding(2)
                    
                    HStack {
                        Circle()
                            .foregroundColor(Color.clear)
                            .frame(width: 6, height: 6)
                        
                    }
                    
                    Spacer().frame(height: 10)
                }
            }
            
            // real-value
            ForEach(datesAndDaysOfMonth, id: \.1) { date, day in
                VStack {
                    Divider()
                    
                    // TODO: 이쪽 처리도 ViewModel과 함께 재구조화할 필요 있음
                    Text(day)
                        .foregroundColor(
                            // TODO: Date 객체를 가지고 선택/오늘 여부 확인하도록
                            (isSelectedMonth && (day == String(selectedDay)))
                            ? (isCurrentMonth && (day == String(todayDay)))
                                ? Color.white
                                : Color.backgroundColor
                            : (isCurrentMonth && (day == String(todayDay)))
                                ? Color.accentColor
                                : weekends.contains(day)
                                    ? Color.gray
                                    : nil
                        )
                        .background(
                            Circle()
                                .foregroundColor(
                                    (isSelectedMonth && (day == String(selectedDay)))
                                    ? (isCurrentMonth && (day == String(todayDay)))
                                        ? Color.accentColor
                                        : nil
                                    : Color.clear
                                )
                                .frame(width: 30, height: 30)
                        )
                        .padding(2)
                        
                        
                    
                    HStack {
                        // TODO: 실제 스케줄 데이터 연동해 그려주도록 구현 (뷰모델 분리 후 작업)
                        Circle()
                            .foregroundColor([17].contains(Int(day)!) ? Color.gray : Color.clear)
                            .frame(width: 6, height: 6)
                        
                    }
                    
                    Spacer().frame(height: 10)
                    
                }
                .onTapGesture {
                    // TODO: 추후 ViewModel로 분리 예정
                    dateHolder.selected = date
                }

            }
        }.background(Color.gray.opacity(0.05))
    }

}

struct MonthlyCalendarItem_Previews: PreviewProvider {
    static let newDateComp = DateComponents(year: 2022, month: 7, day: 3)
    static let newDate = Calendar.current.date(from: newDateComp)!

    static let dateHolder = DateHolder(newDate)
//    static let dateHolder = DateHolder()

    static var previews: some View {
        MonthlyCalendarItem(month: dateHolder.current)
            .environmentObject(dateHolder)
    }
}
