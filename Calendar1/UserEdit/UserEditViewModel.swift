//
// Created by 앱등미니 on 2022/11/26.
//

import Foundation
import Combine

@MainActor
final class UserEditViewModel: ObservableObject {
	var viewDisposalModePublisher = PassthroughSubject<Bool, Never>()

	@Published private(set) var isLoaded: Bool = false
	@Published private(set) var isUpdating: Bool = false

	@Published private var initialUser: User?

	@Published var email: String = ""
	@Published var nickName: String = ""
	@Published var password: String = ""
	@Published var confirmPassword: String = ""

	@Published private(set) var alertMessage: String = "" {
		didSet {
			isShowingAlert = true
		}
	}

	@Published var isShowingAlert: Bool = false

	init() {
		Task {
			try await fetchUser()
		}
	}

	func fetchUser() async throws {
		let response: GetMeResponse = try await Promise.shared.request(.getMe)
		initialUser = response.data

		if let initialUser {
			email = initialUser.email
			nickName = initialUser.nickName ?? ""
		} else {
			viewDisposalModePublisher.send(true)
		}
		isLoaded = true
	}

	func updateUser() {
		Task {
			if password != confirmPassword {
				alertMessage = "비밀번호가 서로 다릅니다"
				return
			}

			isUpdating = true
			let _: GetMeResponse = try await Promise.shared.request(
				.updateMe(email: email, nickName: nickName, password: password)
			)
			isUpdating = false

			viewDisposalModePublisher.send(true)
		}
	}
}
