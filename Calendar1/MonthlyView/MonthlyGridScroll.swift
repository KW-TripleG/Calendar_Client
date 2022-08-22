//
//  MonthlyGridScroll.swift
//  Calendar1
//
//  Created by Coldot on 2022/08/22.
//

import SwiftUI

struct MonthlyGridScroll: View {
    
    @State var pageIndex: Int = 0
    
    @EnvironmentObject var dateHolder: DateHolder
    
    
    var body: some View {
        
//        // 구현 1: ScrollView 활용 _ 구현 중 중단
//        GeometryReader { proxy in
//            ScrollView(showsIndicators: false) {
//                VStack(spacing: 0) {
//                    ForEach(1..<5, id: \.self) { index in
//                        MonthlyGridPicker()
//                    }
//                    .frame(width: proxy.size.width, height: proxy.size.height)
//                }
//            }
//        }
//        .onAppear {
//            UIScrollView.appearance().isPagingEnabled = true
//        }
        
        // 구현 2: TabView 활용
        GeometryReader { proxy in
            TabView(selection: $pageIndex) {
                ForEach(1..<5, id: \.self) { index in
                    MonthlyGridPicker().tag(index)
                }
                .rotationEffect(.init(degrees: -90))
                .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .frame(width: proxy.size.height, height: proxy.size.width)
            .rotationEffect(.degrees(90), anchor: .topLeading)
            .offset(x: proxy.size.width)
            .tabViewStyle(
                PageTabViewStyle(indexDisplayMode: .never)
            )
            
        }
        
    }
}

struct MonthlyGridScroll_Previews: PreviewProvider {
    
    static let dateHolder = DateHolder()
    
    static var previews: some View {
        MonthlyGridScroll()
            .environmentObject(dateHolder)
    }
}
