//
//  HeightReaderView.swift
//  Calendar1
//
//  Created by Coldot on 2022/09/10.
//

import SwiftUI

struct HeightReaderView: View {
    
    let index: Int
    
    @Binding var Heights: [Int: CGFloat?]
    
    var body: some View {
        GeometryReader { proxy in
            Color.clear
                .onAppear {
                    if !(Heights.keys.contains(index)) {
//                        print("Height in HeightReaderView #\(index) = \(proxy.size.height)")
                        Heights.updateValue(proxy.size.height, forKey: index)
                    }
                }
        }
    }
}
