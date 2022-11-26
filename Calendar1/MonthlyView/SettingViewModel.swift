//
// Created by 앱등미니 on 2022/11/26.
//

import Foundation

@MainActor
final class SettingViewModel: ObservableObject {
	@Published private(set) var user: User?

	init() {
		Task {
			try await fetchUser()
		}
	}

	private func fetchUser() async throws {
		let response: GetMeResponse = try await Promise.shared.request(.getMe)
		user = response.data
	}
}
