//
//  MonthlyCalendarViewModel.swift
//  Calendar1
//
//  Created by woody on 2022/09/26.
//

import SwiftUI

struct MonthData: Hashable {
    let index: Int
    let month: Date
}

final class MonthlyCalendarModel: ObservableObject {
    @Published private(set) var height: CGFloat?
    @Published private(set) var monthDatas: [MonthData] = []
    
    private var heightCache: [Int: CGFloat?] = [:]
    private let currentDate: Date
    
    init() {
        let currentDate = Date()
        let monthDatas = (-30...30).map { index in
            MonthData(index: index, month: CalendarHelper().getMonthAdding(index, to: currentDate))
        }
        
        self.currentDate = currentDate
        self.monthDatas = monthDatas
    }
}

extension MonthlyCalendarModel {
    func pageIndexChanged(_ pageIndex: Int) {
        self.updateHeightIfNeeded(with: pageIndex)
        self.createMonthDatasIfNeeded(with: pageIndex)
    }
    
    func updateHeightCache(with index: Int, height: CGFloat?) {
        guard height != .zero else { return }
        
        heightCache[index] = height
    }
}

extension MonthlyCalendarModel {
    private func updateHeightIfNeeded(with pageIndex: Int) {
        guard let height = heightCache[pageIndex] else { return }
        
        self.height = height
    }
    
    private func createMonthDatasIfNeeded(with pageIndex: Int) {
        if let firstIndex = self.monthDatas.first?.index, pageIndex == firstIndex {
            let insertedMonthDatas = (abs(firstIndex) + 1...abs(firstIndex) + 20).map { index in
                MonthData(index: -index, month: CalendarHelper().getMonthAdding(-index, to: currentDate))
            }.reversed()
            
            self.monthDatas = insertedMonthDatas + self.monthDatas
        }
        
        if let lastIndex = self.monthDatas.last?.index, pageIndex == lastIndex {
            let appendedMonthDatas = (lastIndex + 1...lastIndex + 20).map { index in
                MonthData(index: index, month: CalendarHelper().getMonthAdding(index, to: currentDate))
            }
            self.monthDatas += appendedMonthDatas
        }
    }
}
