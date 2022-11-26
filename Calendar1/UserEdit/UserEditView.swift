//
// Created by 앱등미니 on 2022/11/26.
//

import Foundation
import SwiftUI

struct UserEditView: View {
	@StateObject private var viewModel: UserEditViewModel
	@Environment(\.presentationMode) private var presentation

	init(_ viewModel: UserEditViewModel) {
		self._viewModel = .init(wrappedValue: viewModel)
	}

	var body: some View {
		NavigationView {
			Form {
				Section {
					if viewModel.isLoaded {
						TextField("닉네임", text: $viewModel.nickName)
								.textContentType(.username)

						TextField("이메일", text: $viewModel.email)
								.textContentType(.emailAddress)

						SecureField("비밀번호", text: $viewModel.password)
								.textInputAutocapitalization(.never)
								.disableAutocorrection(true)
								.background(Color.textFieldColor)
								.textContentType(.password)
								.privacySensitive()

						SecureField("비밀번호 확인", text: $viewModel.confirmPassword)
								.textInputAutocapitalization(.never)
								.disableAutocorrection(true)
								.background(Color.textFieldColor)
								.textContentType(.password)
								.privacySensitive()
					} else {
						ProgressView()
								.progressViewStyle(CircularProgressViewStyle())
					}
				}

				Section {
					Button {
						viewModel.updateUser()
					} label: {
						Text("제출")
								.foregroundColor(.blue)
					}.disabled(!viewModel.isLoaded || viewModel.isUpdating)
				}
			}
		}.navigationBarTitle("유저 수정")
				.onReceive(viewModel.viewDisposalModePublisher) { output in
					if output { presentation.wrappedValue.dismiss() }
				}
				.alert(viewModel.alertMessage, isPresented: $viewModel.isShowingAlert) {
					Button("확인", role: .cancel) { }
				}
	}
}
