//
//  FieldExtention.swift
//  Calendar1
//
//  Created by Coldot on 2022/11/20.
//

import Foundation
import SwiftUI


extension TextField {
    func authViewFieldStyle() -> some View {
        modifier(AuthTextFieldStyle())
    }
}

extension SecureField {
    func authViewFieldStyle() -> some View {
        modifier(AuthTextFieldStyle())
    }
}
