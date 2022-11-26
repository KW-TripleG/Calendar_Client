//
// Created by 앱등미니 on 2022/11/26.
//

import Foundation

struct GetMeResponse: Codable {
	let status: String
	let message: String
	let data: User
}
