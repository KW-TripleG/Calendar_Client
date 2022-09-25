//
//  HeightReaderView.swift
//  Calendar1
//
//  Created by Coldot on 2022/09/10.
//

import SwiftUI

struct HeightReaderView: View {
  private let index: Int
  
  init(index: Int) {
    self.index = index
  }
  
    var body: some View {
        GeometryReader { proxy in
            Color.clear
            .preference(key: HeightPreferenceKey.self, value: .init(index: index, height: proxy.size.height))
        }
    }
}
