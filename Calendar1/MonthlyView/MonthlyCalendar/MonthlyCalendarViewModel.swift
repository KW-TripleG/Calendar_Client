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

struct HeightAnimation: Equatable {
    let height: CGFloat?
    let shouldAnimate: Bool
}

final class MonthlyCalendarModel: ObservableObject {
    @Published private(set) var heightAnimation: HeightAnimation = .init(height: nil, shouldAnimate: false)
    @Published private(set) var monthDatas: [MonthData] = []
    @Published private(set) var schedules: [ScheduleWithDate] = []
    
    private var heightCache: [Int: CGFloat?] = [:]
    private let currentDate: Date
    
    init() {
        let currentDate = Date()
        let monthDatas = (-30...30).map { index in
            MonthData(index: index, month: CalendarHelper.getMonthAdding(index, to: currentDate))
        }
        
        self.currentDate = currentDate
        self.monthDatas = monthDatas

        Task {
            try await fetchSchedules()
        }
    }
}

extension MonthlyCalendarModel {
    func pageIndexChanged(_ pageIndex: Int) {
        self.updateHeightIfNeeded(with: pageIndex)
        self.createMonthDatasIfNeeded(with: pageIndex)
    }
    
    func updateHeightCache(with index: Int, height: CGFloat?) {
        guard height != .zero else { return }
        
        if index == .zero && heightCache[index] == nil {
            self.heightAnimation = .init(height: height, shouldAnimate: false)
        }
        
        heightCache[index] = height
    }
}

extension MonthlyCalendarModel {
    private func updateHeightIfNeeded(with pageIndex: Int) {
        guard let height = heightCache[pageIndex] else { return }
        
        self.heightAnimation = .init(height: height, shouldAnimate: true)
    }
    
    private func createMonthDatasIfNeeded(with pageIndex: Int) {
        if let firstIndex = self.monthDatas.first?.index, pageIndex == firstIndex {
            let insertedMonthDatas = (abs(firstIndex) + 1...abs(firstIndex) + 20).map { index in
                MonthData(index: -index, month: CalendarHelper.getMonthAdding(-index, to: currentDate))
            }.reversed()
            
            self.monthDatas = insertedMonthDatas + self.monthDatas
        }
        
        if let lastIndex = self.monthDatas.last?.index, pageIndex == lastIndex {
            let appendedMonthDatas = (lastIndex + 1...lastIndex + 20).map { index in
                MonthData(index: index, month: CalendarHelper.getMonthAdding(index, to: currentDate))
            }
            self.monthDatas += appendedMonthDatas
        }
    }
}

extension MonthlyCalendarModel {
    private func fetchSchedules() async throws {
        let response: ScheduleResponse = try await Promise.shared.request(.fetchSchedules)
        schedules = response.data.map { element in try! element.asScheduleWithDate() }
    }
}
