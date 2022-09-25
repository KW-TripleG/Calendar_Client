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
        VStack(spacing: 0) {
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
            .onChange(of: pageIndex, perform: self.viewModel.pageIndexChanged)
            .frame(height: calendarHeight)
            .onChange(of: viewModel.height) { height in
                withAnimation() {
                    calendarHeight = height
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
