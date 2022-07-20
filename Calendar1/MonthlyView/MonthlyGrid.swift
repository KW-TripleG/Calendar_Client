//
//  MonthlyGrid.swift
//  Calendar1
//
//  Created by Coldot on 2022/07/19.
//

import SwiftUI

struct MonthlyGrid: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                    .frame(height: 10)
            }
            
//            Text("MonthlyGrid")
            
            let calendarHelper = CalendarHelper()
            let todayDay = calendarHelper.getDayOfMonth(dateHolder.date)
            let daysInMonth = calendarHelper.getDaysInMonth(dateHolder.date)
            let firstWeekday = calendarHelper.getFirstWeekdayOfMonth(dateHolder.date)
            let weekends = calendarHelper.getWeekendDaysInMonth(dateHolder.date).map {"\($0)"}
            let dayNames = ["일", "월", "화", "수", "목", "금", "토"]
            let data = Array(1...daysInMonth).map {"\($0)"}
            let cols: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)
            
            
            LazyVGrid(columns: cols, spacing: 0) {
                
                // title
                ForEach(dayNames, id: \.self) { n in
                    VStack {
                        Text(n)
                            .font(.system(
                                size: 11))
                            .opacity(["일", "토"].contains(n) ? 0.5 : 1)
                        
                        Spacer().frame(height: 5)
                    }
                }
            }
            
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
                ForEach(data, id: \.self) {day in
                    VStack {
                        Divider()
                        
                        Text(day)
                            .foregroundColor(day == String(todayDay) ? Color.white : weekends.contains(day) ? Color.gray : nil)
                            .background(
                                Circle()
                                    .foregroundColor(day == String(todayDay) ? Color.accentColor : Color.clear)
                                    .frame(width: 30, height: 30)
                            )
                            .padding(2)
                        
                        HStack {
                            Circle()
                                .foregroundColor([17].contains(Int(day)!) ? Color.gray : Color.clear)
//                                .foregroundColor(Color.clear)
                                .frame(width: 6, height: 6)
                            
                        }
                        
                        Spacer().frame(height: 10)
                        
                    }
                }
            }.background(Color.gray.opacity(0.05))
            
        }
    }
}

struct MonthlyGrid_Previews: PreviewProvider {
    
    static let newDateComp = DateComponents(year: 2022, month: 9, day: 3)
    static let newDate = Calendar.current.date(from: newDateComp)!

    static let dateHolder = DateHolder(newDate)
//    static let dateHolder = DateHolder()
    
    static var previews: some View {
//        ContentView()
        MonthlyGrid()
            .environmentObject(dateHolder)
    }
}
