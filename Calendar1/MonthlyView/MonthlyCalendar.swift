//
//  MonthlyCalendar.swift
//  Calendar1
//
//  Created by Coldot on 2022/08/22.
//

import SwiftUI


struct MonthlyCalendar: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    @State var calHeight: CGFloat? = nil
    @State var calHeights: [Int: CGFloat?] = [:]
    
    @State var pageIndex: Int = 0
    @State var numOfBackwardPages: Int = 6
    @State var numOfForwardPages: Int = 6
    
    
    var body: some View {
        
        let calendarHelper = CalendarHelper()
        let nowMonth = calendarHelper.getFirstOfMonth(dateHolder.date)
        
        VStack(spacing: 0) {
            MonthlyCalendarTitle()
            
            TabView(selection: $pageIndex) {
                
                // 현재 이전 월들
                ForEach(-numOfBackwardPages ... -1, id: \.self) { index in
                    let month = calendarHelper.getMonthAdding(index, to: nowMonth)
                    
                    MonthlyCalendarItem(month: month)
                        .tag(index)
                        .background(
                            HeightReaderView(index: index, Heights: $calHeights)
                        )
                }

                // 현재 월
                MonthlyCalendarItem(month: nowMonth)
                    .tag(0)
                    .background(
                        HeightReaderView(index: 0, Heights: $calHeights)
                    )
                    .onAppear {
                        // 초기 높이 세팅 (초기에는 TabView의 onChange(of: pageindex) 수정자가 호출되지 않음)
                        if (pageIndex == 0 && calHeights.keys.contains(0)) {
                            calHeight = calHeights[0]!
                        }
                    }

                // 현재 이후 월들
                ForEach(1 ... numOfForwardPages, id: \.self) { index in
                    let month = calendarHelper.getMonthAdding(index, to: nowMonth)

                    MonthlyCalendarItem(month: month)
                        .tag(index)
                        .background(
                            HeightReaderView(index: index, Heights: $calHeights)
                        )
                }
                
            }
            .tabViewStyle(
                PageTabViewStyle(indexDisplayMode: .never)
            )
            .onChange(of: pageIndex) { _ in
                
                // calHeight 업데이트 (동적 높이 조절)
                if (calHeights.keys.contains(pageIndex)) {
                    withAnimation() {
                        calHeight = calHeights[pageIndex]!
                    }
                }
                
                // 페이지 확장 처리
                if pageIndex == -numOfBackwardPages {
                    numOfBackwardPages += 6
                }
                if pageIndex == numOfForwardPages {
                    numOfForwardPages += 6
                }

            }
            .frame(height: calHeight)
            
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
