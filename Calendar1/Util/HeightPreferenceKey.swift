//
//  HeightPreferenceKey.swift
//  Calendar1
//
//  Created by heoblitz on 2022/09/26.
//

import SwiftUI

struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: HeightPreference = HeightPreference()
    
    static func reduce(value: inout HeightPreference, nextValue: () -> HeightPreference) {
        self.defaultValue = nextValue()
    }
}

struct HeightPreference: Equatable {
    var index = 0
    var height = CGFloat.zero
}
