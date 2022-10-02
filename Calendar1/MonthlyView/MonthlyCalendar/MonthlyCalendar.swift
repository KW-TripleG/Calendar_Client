//
//  MonthlyCalendar.swift
//  Calendar1
//
//  Created by Coldot on 2022/08/22.
//

import SwiftUI

struct MonthlyCalendar: View {
    @State private var pageIndex: Int = 0
    @State private var calendarHeight: CGFloat?
    @StateObject private var viewModel = MonthlyCalendarModel()
    
    var body: some View {
        VStack {
            MonthlyCalendarTitle()
            TabView(selection: $pageIndex) {
                ForEach(viewModel.monthDatas, id: \.self) { monthDate in
                    MonthlyCalendarItem(month: monthDate.month)
                        .tag(monthDate.index)
                        .background(
                            HeightReaderView(index: monthDate.index)
                                .onPreferenceChange(HeightPreferenceKey.self) {
                                    viewModel.updateHeightCache(with: $0.index, height: $0.height)
                                }
                        )
                }
            }
            .tabViewStyle(
                PageTabViewStyle(indexDisplayMode: .never)
            )
            .frame(height: calendarHeight)
            .onChange(of: pageIndex, perform: viewModel.pageIndexChanged)
            .onChange(of: viewModel.heightAnimation) { heightAnimation in
                guard heightAnimation.shouldAnimate else {
                    calendarHeight = heightAnimation.height
                    return
                }
                
                withAnimation() {
                    calendarHeight = heightAnimation.height
                }
            }
        }
    }
}

struct MonthlyCalendar_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyCalendar()
    }
}
