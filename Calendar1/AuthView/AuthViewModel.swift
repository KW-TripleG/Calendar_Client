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
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var passwordNew: String = ""
    @Published var passwordConf: String = ""
    @Published var name: String = ""
    @Published var email: String = ""
    
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
                let response: LoginResponse = try await Promise.shared.request(
                    .login(
                        id: self.username,
                        password: self.password
                    ))
              
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
                let response: JoinResponse = try await Promise.shared.request(
                    .join(
                        id: self.username,
                        password: self.passwordNew,
                        name: name,
                        email: email
                    ))
              
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
        guard (passwordNew == passwordConf) else { return false }
        
        return true
    }

    private func cleanUpInputDatas() {
        self.password = ""
        self.passwordNew = ""
        self.passwordConf = ""
        self.name = ""
        self.email = ""
    }
}
