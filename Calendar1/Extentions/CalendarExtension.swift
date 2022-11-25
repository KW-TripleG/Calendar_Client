//
//  CalendarExtension.swift
//  Calendar1
//
//  Created by Coldot on 2022/11/24.
//

import Foundation


extension Calendar {
    static var currentKST: Calendar {
        var currentKST = Calendar.current
        currentKST.timeZone = TimeZone(abbreviation: "KST")!
        return currentKST
    }
}
