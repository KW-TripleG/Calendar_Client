//
//  AuthViewModel.swift
//  Calendar1
//
//  Created by Coldot on 2022/10/03.
//

import SwiftUI


// MARK: - AuthViewModel
@MainActor
final class AuthViewModel: ObservableObject {
    private var globalRouter: GlobalRouter
  
    @Published private(set) var willSignIn: Bool
    
    @Published var input_username: String = ""
    @Published var input_password: String = ""
    @Published var input_password_new: String = ""
    @Published var input_password_conf: String = ""
    @Published var input_name: String = ""
    @Published var input_email: String = ""
    
    @Published var isSignUpSucceed: Bool = false
    
    
    init(globalRouter: GlobalRouter) {
        self.willSignIn = true
        self.globalRouter = globalRouter
    }
}


// MARK: - Actions
extension AuthViewModel {
    func toggleSignIn() {
        self.willSignIn.toggle()
    }

    
    func signInButtonClicked() {
        Task {
            do {
                let response: LoginResponse = try await Promise.shared.request(.login(id: self.input_username, password: self.input_password))
              
                if response.status == 200 {
                  self.globalRouter.screen = .calendar
                }
            } catch let error {
                print(error)
            }
        }
        
        self.cleanUpInputDatas()
    }
    
    
    func signUpButtonClicked() {
        // TODO: 예외 처리로 validate하도록 변경
        guard (validateUserData()) else {
            return
        }
        
        Task {
            do {
                let response: JoinResponse = try await Promise.shared.request(.join(id: self.input_username, password: self.input_password_new, name: input_name, email: input_email))
              
                if response.status == 200 {
                  self.isSignUpSucceed = true
                }
                
            } catch let error {
                print(error)
            }
        }
    }
    
    
    func signUpAlertDismissed() {
        self.cleanUpInputDatas()
        self.willSignIn = true
    }
}


// MARK: - Private
extension AuthViewModel {
    private func validateUserData() -> Bool {
        guard (input_password_new == input_password_conf) else { return false }
        
        return true
    }

    private func cleanUpInputDatas() {
        self.input_password = ""
        self.input_password_new = ""
        self.input_password_conf = ""
        self.input_name = ""
        self.input_email = ""
    }
}
