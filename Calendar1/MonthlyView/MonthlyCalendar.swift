//
//  MonthlyCalendar.swift
//  Calendar1
//
//  Created by Coldot on 2022/08/22.
//

import SwiftUI


struct MonthlyCalendar: View {
    
    @State var pageIndex: Int = 0
    @State var numOfBackwardPages: Int = 6
    @State var numOfForwardPages: Int = 6
    
    @EnvironmentObject var dateHolder: DateHolder
    
    
    var body: some View {
        
        let calendarHelper = CalendarHelper()
        let nowMonth = calendarHelper.getFirstOfMonth(dateHolder.date)
        
        VStack(spacing: 0) {
            MonthlyCalendarTitle()
            
            GeometryReader { proxy in
                TabView(selection: $pageIndex) {
                    
                    ForEach(-numOfBackwardPages ... -1, id: \.self) { index in
                        let month = calendarHelper.getMonthAdding(index, to: nowMonth)
                        
                        MonthlyCalendarItem(month: month)
                            .tag(index)
                            .rotationEffect(.init(degrees: -90))
                            .frame(width: proxy.size.width, height: proxy.size.height)
                    }

                    MonthlyCalendarItem(month: nowMonth)
                        .tag(0)
                        .rotationEffect(.init(degrees: -90))
                        .frame(width: proxy.size.width, height: proxy.size.height)

                    ForEach(1 ... numOfForwardPages, id: \.self) { index in
                        let month = calendarHelper.getMonthAdding(index, to: nowMonth)
                        
                        MonthlyCalendarItem(month: month)
                            .tag(index)
                            .rotationEffect(.init(degrees: -90))
                            .frame(width: proxy.size.width, height: proxy.size.height)
                    }
                    
                }
                .frame(width: proxy.size.height, height: proxy.size.width)
                .rotationEffect(.degrees(90), anchor: .topLeading)
                .offset(x: proxy.size.width)
                .tabViewStyle(
                    PageTabViewStyle(indexDisplayMode: .never)
                )
                .onChange(of: pageIndex) { i in
                    if pageIndex == -numOfBackwardPages {
                        numOfBackwardPages += 6
                    }
                    if pageIndex == numOfForwardPages {
                        numOfForwardPages += 6
                    }
                }
            }
        }
        
        
        
        
    }
}

struct MonthlyCalendar_Previews: PreviewProvider {
    
    static let dateHolder = DateHolder()
    
    static var previews: some View {
        MonthlyCalendar()
            .environmentObject(dateHolder)
            .previewDevice("iPhone 13 mini")
    }
}
