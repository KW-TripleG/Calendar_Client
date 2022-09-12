//
//  MonthlyCalendar.swift
//  Calendar1
//
//  Created by Coldot on 2022/08/22.
//

import SwiftUI

struct MonthlyCalendar: View {
    private struct MonthData: Hashable {
        let index: Int
        let month: Date
    }
    
    @State private var calHeight: CGFloat? = nil
    @State private var calHeights: [Int: CGFloat?] = [:]
    @State private var pageIndex: Int = 0
    @State private var monthDatas: [MonthData]
    
    private let calendarHelper = CalendarHelper()
    private let currentDate: Date
    
    init() {
        let currentDate = Date()
        let monthDatas = (-20...20).map { index in
            MonthData(index: index, month: CalendarHelper().getMonthAdding(index, to: currentDate))
        }
        
        self.currentDate = currentDate
        self._monthDatas = State(initialValue: monthDatas)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            MonthlyCalendarTitle()
            TabView(selection: $pageIndex) {
                ForEach(self.monthDatas, id: \.self) { monthDate in
                    MonthlyCalendarItem(month: monthDate.month)
                        .tag(monthDate.index)
                        .background(
                            HeightReaderView(index: monthDate.index, Heights: self.$calHeights)
                        ).onAppear {
                            // 초기 높이 세팅 (초기에는 TabView의 onChange(of: pageindex) 수정자가 호출되지 않음)
                            if (pageIndex == 0 && calHeights.keys.contains(0)) {
                                calHeight = calHeights[0]!
                            }
                        }
                }
            }
            .tabViewStyle(
                PageTabViewStyle(indexDisplayMode: .never)
            )
            .onChange(of: pageIndex) { _ in
                // calHeight 업데이트 (동적 높이 조절)
              
                // 페이지 확장 처리
                var isUpdated: Bool = false
                
                // TODO: prev append 시 레이아웃 깨짐
                // 리서칭 후 다시 수정하기 by heoblitz
                if let firstIndex = self.monthDatas.first?.index, pageIndex == firstIndex {
                    let insertedMonthDatas = (abs(firstIndex) + 1...abs(firstIndex) + 20).map { index in
                        MonthData(index: -index, month: CalendarHelper().getMonthAdding(-index, to: currentDate))
                    }.reversed()
                    
                    self.monthDatas = insertedMonthDatas + self.monthDatas
                    isUpdated = true
                }
                
                if let lastIndex = self.monthDatas.last?.index, pageIndex == lastIndex {
                    let appendedMonthDatas = (lastIndex + 1...lastIndex + 20).map { index in
                        MonthData(index: index, month: CalendarHelper().getMonthAdding(index, to: currentDate))
                    }
                    self.monthDatas += appendedMonthDatas
                    isUpdated = true
                }
                
                // MARK: @State 업데이트와 겹치면 height 레이아웃 반영안됨
                // 따라서 레이아웃 업데이트 미루어줌. by heoblitz
                guard isUpdated else {
                    if (calHeights.keys.contains(pageIndex)) {
                        withAnimation() {
                            calHeight = calHeights[pageIndex]!
                        }
                    }
                    return
                }
    
                DispatchQueue.main.async {
                    if (calHeights.keys.contains(pageIndex)) {
                        withAnimation() {
                            calHeight = calHeights[pageIndex]!
                        }
                    }
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
