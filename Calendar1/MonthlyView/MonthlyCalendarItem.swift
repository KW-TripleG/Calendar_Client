//
//  MonthlyCalendarItem.swift
//  Calendar1
//
//  Created by Coldot on 2022/07/19.
//

import SwiftUI

struct MonthlyCalendarItem: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    let month: Date
    
    
    var body: some View {
        
        let todayDay = CalendarHelper.getDayOfMonth(dateHolder.date)
        let daysInMonth = CalendarHelper.getDaysInMonth(month)
        
        let weekends = CalendarHelper.getWeekendDaysInMonth(month).map {"\($0)"}
        
        let datesOfCurrentMonth = CalendarHelper.getDatesOfMonth(dateHolder.date)
        let daysOfCuttentMonth = Array(1...daysInMonth).map {"\($0)"}
        let zipOfCurrentMonth = Array(zip(datesOfCurrentMonth, daysOfCuttentMonth))
        let firstWeekday = CalendarHelper.getFirstWeekdayOfMonth(month)
        
        let cols: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)
        

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
            ForEach(zipOfCurrentMonth, id: \.1) { date, day in
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

struct MonthlyCalendarItem_Previews: PreviewProvider {
    static let newDateComp = DateComponents(year: 2022, month: 7, day: 3)
    static let newDate = Calendar.current.date(from: newDateComp)!

    static let dateHolder = DateHolder(newDate)
//    static let dateHolder = DateHolder()

    static var previews: some View {
        MonthlyCalendarItem(month: dateHolder.date)
            .environmentObject(dateHolder)
            .previewDevice("iPhone 13 mini")
    }
}
