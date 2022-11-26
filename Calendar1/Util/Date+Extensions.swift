//
//  Date+Extensions.swift
//  Calendar1
//
//  Created by woody on 2022/11/26.
//

import Foundation

extension Date {
  var dateWithOutTime: Date {
    guard let parsedDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
      fatalError("Failed to strip time from Date object")
    }
    
    return parsedDate
  }
}
