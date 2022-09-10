//
//  RotationAndFrameTest.swift
//  Calendar1
//
//  Created by Coldot on 2022/09/02.
//

import SwiftUI


struct RotationAndFrameTest: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    @State var calHeightInput: String = ""
    @State var calHeights: [Int: CGFloat?] = [:]
    @State var calHeight: CGFloat? = nil
    @State var pageIndex: Int = 0
    
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            MonthlyCalendarTitle()
            
            GeometryReader { proxy in
                TabView(selection: $pageIndex) {
                    ForEach(-10 ... 10, id: \.self) { i in
                        let nowMonth = CalendarHelper().getFirstOfMonth(dateHolder.date)
                        let month = CalendarHelper().getMonthAdding(i, to: nowMonth)
                        
                        MonthlyCalendarItem(month: month)
                            .background(
                                HeightReaderView(index: i, Heights: $calHeights)
                            )
                            .rotationEffect(.degrees(-90))
                            .frame(width: proxy.size.width, height: proxy.size.height)
                            .tag(i)
                    }
                    
                }
                .frame(width: proxy.size.height, height: proxy.size.width)
                .rotationEffect(.degrees(90), anchor: .topLeading)
                .offset(x: proxy.size.width)
                
                .tabViewStyle(
                    PageTabViewStyle(indexDisplayMode: .never)
                )
                .onChange(of: pageIndex) { val in
                    
                    if (calHeights.keys.contains(pageIndex)) {
                        withAnimation() {
                            calHeight = calHeights[pageIndex]!
                        }
                    }
                }
                
                
            }
            .frame(height: calHeight)
            
            
//            HStack {
//                Button("-1") {
//                    pageIndex -= 1
//                }
//                Spacer()
//                Button("\(pageIndex)") {
//                    pageIndex = pageIndex
//                }
//                Spacer()
//                Button("+1") {
//                    pageIndex += 1
//                }
//            }
//            .padding()
            
//            HStack {
//                TextField("Enter Size", text: $calHeightInput)
//                Button("Apply") {
//                    if let n = NumberFormatter().number(from: calHeightInput) {
//                        calHeight = CGFloat(truncating: n)
//                    }
//                }
//            }
//            .padding()
            
            
            DailyScheduleView()
            
            BottomControlView()
            
        }
        
    }
}

struct RotationAndFrameTest_Previews: PreviewProvider {
    static let dateHolder = DateHolder()
    
    static var previews: some View {
        RotationAndFrameTest()
            .environmentObject(dateHolder)
            .previewDevice("iPhone 13 mini")
    }
}
