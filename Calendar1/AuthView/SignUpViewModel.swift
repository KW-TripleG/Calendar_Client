//
//  AuthViewModel.swift
//  Calendar1
//
//  Created by Coldot on 2022/10/03.
//

import SwiftUI


// MARK: - AuthViewModel
@MainActor
final class SignUpViewModel: ObservableObject {
  private var globalRouter: GlobalRouter
  
  @Published var alertMessage: String = "" {
    didSet {
      guard !alertMessage.isEmpty else { return }
      
      self.isShowingAlert = true
    }
  }
  
  @UserDefault(key: "jwt", defaultValue: nil) private var jwt: String?
  
  @Published var isShowingAlert: Bool = false
  
  @Published var id: String = ""
  @Published var password: String = ""
  @Published var passwordConf: String = ""
  @Published var name: String = ""
  @Published var email: String = ""
  
  init(globalRouter: GlobalRouter) {
    self.globalRouter = globalRouter
  }
}


// MARK: - Actions
extension SignUpViewModel {
  func signInButtonTapped() {
    self.globalRouter.screen = .signIn
  }
  
  func signUpButtonClicked() {
    guard self.isFillSignUpDatas() else {
      self.alertMessage = "모든 빈칸을 채워주세요."
      return
    }
    
    guard self.validateUserData() else {
      self.alertMessage = "비밀번호가 서로 다릅니다. 다시 입력해주세요."
      return
    }
    
    Task {
      do {
        let response: JoinResponse = try await Promise.shared.request(
          .join(id: self.id, password: self.password, name: self.name, email: self.email)
        )
        
        if response.status == "OK" {
          self.jwt = response.jwt
          self.alertMessage = "회원가입이 완료되었습니다."
        } else if response.status == "BAD_REQUEST" {
          self.alertMessage = response.message
        }
      } catch let error {
        print(error)
      }
    }
  }
  
  func alertActionHandler() {
    guard self.alertMessage == "회원가입이 완료되었습니다." else { return }
    
    self.globalRouter.screen = .calendar
  }
}

// MARK: - Private
extension SignUpViewModel {
  private func validateUserData() -> Bool {
    guard (password == passwordConf) else { return false }
    
    return true
  }
  
  private func isFillSignUpDatas() -> Bool {
    return !id.isEmpty
    && !password.isEmpty
    && !passwordConf.isEmpty
    && !name.isEmpty
    && !email.isEmpty
  }
}
