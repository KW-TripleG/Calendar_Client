//
//  Calendar1App.swift
//  Calendar1
//
//  Created by Coldot on 2022/07/18.
//

import SwiftUI

@main
struct Calendar1App: App {
    var body: some Scene {
        WindowGroup {
            
            let dateHolder = DateHolder()
            let globalRouter = GlobalRouter()
            
            ContentView()
                .environmentObject(dateHolder)
                .environmentObject(globalRouter)
        }
    }
}
