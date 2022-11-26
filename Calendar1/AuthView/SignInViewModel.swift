//
//  SignInViewModel.swift
//  Calendar1
//
//  Created by woody on 2022/11/26.
//

import Foundation

@MainActor
final class SignInViewModel: ObservableObject {
  private var globalRouter: GlobalRouter
  
  @Published var alertMessage: String = "" {
    didSet {
      guard !alertMessage.isEmpty else { return }

      self.isShowingAlert = true
    }
  }
  
  @Published var isShowingAlert: Bool = false
  @Published var id: String = ""
  @Published var password: String = ""
  
  init(globalRouter: GlobalRouter) {
    self.globalRouter = globalRouter
  }
  
  func signInButtonTapped() {
    guard id.isEmpty == false && password.isEmpty == false else {
      self.alertMessage = "아이디 및 패스워드를 입력해주세요"
      return
    }
    
    Task {
      do {
        let response: LoginResponse = try await Promise.shared.request(.login(id: self.id, password: self.password))
        
        if response.status == "OKAY" {
          self.globalRouter.screen = .calendar
        } else {
          self.alertMessage = response.message
        }
      } catch let error {
        self.alertMessage = error.localizedDescription
      }
    }
  }
  
  func signUpButtonTapped() {
    self.globalRouter.screen = .signUp
  }
}
