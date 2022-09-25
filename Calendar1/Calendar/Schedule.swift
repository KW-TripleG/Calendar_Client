//
// Created by 앱등미니 on 2022/09/24.
//

import Foundation

struct Schedule {
	var id: Int
	var title: String
	var content: String?
	var userID: String
	var togetherID: String?

	init(id: Int, title: String, content: String?, userID: String, togetherID: String?) {
		self.id = id
		self.title = title
		self.content = content
		self.userID = userID
		self.togetherID = togetherID
	}
}
