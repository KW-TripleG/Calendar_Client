//
//  DateHolder.swift
//  Calendar1
//
//  Created by Coldot on 2022/07/19.
//

import Foundation

class DateHolder: ObservableObject {
    
    @Published var current: Date
    @Published var selected: Date
    
    // init to current date
    init() {
        self.current = Date()
        self.selected = Date()
    }
    
    // init to custom date (for test)
    init(_ date: Date) {
        self.current = date
        self.selected = date
    }
}
