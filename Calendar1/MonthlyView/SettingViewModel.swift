//
// Created by 앱등미니 on 2022/11/26.
//

import Foundation

@MainActor
final class SettingViewModel: ObservableObject {
	private var globalRouter: GlobalRouter
	private var global: Global

	@Published private(set) var user: User?
	@UserDefault(key: "jwt", defaultValue: nil) private var jwt: String?

	init(_ global: Global, _ globalRouter: GlobalRouter) {
		self.global = global
		self.globalRouter = globalRouter

		fetchUser()
	}

	func fetchUser() {
		Task {
			let response: GetMeResponse = try await Promise.shared.request(.getMe)
			user = response.data
		}
	}

	func signOut() {
		global.clear()
		jwt = nil
		globalRouter.screen = .signIn
	}
}
