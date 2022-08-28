//
//  ContentView.swift
//  Calendar1
//
//  Created by Coldot on 2022/07/18.
//

import SwiftUI


struct ContentView: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View {
        MonthlyView()
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let dateHolder = DateHolder()
    
    static var previews: some View {
        ContentView()
            .environmentObject(dateHolder)
    }
}
