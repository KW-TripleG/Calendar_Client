//
//  DateHolder.swift
//  Calendar1
//
//  Created by Coldot on 2022/07/19.
//

import Foundation

class DateHolder: ObservableObject {
    
    @Published var date: Date
    
    // init to current date
    init() {
        self.date = Date()
    }
    
    // init to custom date
    init(_ date: Date) {
        self.date = date
    }
}
