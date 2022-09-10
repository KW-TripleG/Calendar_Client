//
//  MonthlyCalendarTitle.swift
//  Calendar1
//
//  Created by Coldot on 2022/08/22.
//

import SwiftUI

struct MonthlyCalendarTitle: View {
    var body: some View {
        
        VStack(spacing: 0) {
            let cols: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)
            
            
            LazyVGrid(columns: cols, spacing: 0) {
                
                let dayNames = ["일", "월", "화", "수", "목", "금", "토"]
                
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
            
        }
    }
}

struct MonthlyCalendarTitle_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyCalendarTitle()
    }
}
