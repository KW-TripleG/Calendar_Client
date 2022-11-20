//
//  JoinResponse.swift
//  Calendar1
//
//  Created by Coldot on 2022/11/20.
//

import Foundation

struct JoinResponse: Codable {
    let data: String
    let status: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case status
        case message
    }
}
