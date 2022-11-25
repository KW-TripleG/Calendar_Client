//
//  MonthlyView.swift
//  Calendar1
//
//  Created by Coldot on 2022/07/19.
//

import SwiftUI

struct MonthlyView: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    @EnvironmentObject var global: Global
    
    @State var scheduleViewToggle: Bool = true
    
    
    var body: some View {
        NavigationView() {
            ZStack {
                // background layer
                Color.gray
                    .opacity(0.075)
                    .ignoresSafeArea()
                
                // main layer
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                            .frame(height: 5)
                    }

                    MonthlyCalendar()
                    
                    DailyScheduleView()
                        .background(Color.backgroundColor)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        BottomControlView()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading: HStack {
                        Button (
                            action: {},
                            label: {
                                Image(systemName: "chevron.left")
                                Text(CalendarHelper().getYearMonthStr(global.selectedDate))
                            }
                        )
                    },
                    
                    trailing: HStack(spacing: 15){
                        Button(
                            action: {
                                scheduleViewToggle.toggle()
                            },
                            label: {
                                Image(systemName: "list.bullet.below.rectangle")
                            })
                        .padding(EdgeInsets.init(top: 1, leading: -4, bottom: 1, trailing: 4))
                        .foregroundColor(scheduleViewToggle ? Color.white : Color.accentColor)
                        .background(scheduleViewToggle ? Color.accentColor : nil)
                        .cornerRadius(5)
                        
                        Button(action: {}, label: {
                            Image(systemName: "magnifyingglass")
                        })
                        
                        Button(action: {}, label: {
                            Image(systemName: "plus")
                        })
                })
            }
        }
        
    }
}

struct MonthlyView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyView()
            .environmentObject(Global())
            
    }
}
