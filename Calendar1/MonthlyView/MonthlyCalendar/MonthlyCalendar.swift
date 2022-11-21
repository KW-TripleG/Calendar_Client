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
    
    // TODO: 다른 월로 스크롤하여 넘어갈 경우 Selection도 넘어간 월의 1일로 설정되도록 하는 기능 구현 (시간 되면 추후 진행)
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
