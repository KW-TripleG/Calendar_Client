//
//  AuthViewModel.swift
//  Calendar1
//
//  Created by Coldot on 2022/10/03.
//

import SwiftUI

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
    
    
    init(globalRouter: GlobalRouter) {
        self.willSignIn = true
        self.globalRouter = globalRouter
    }
}


extension AuthViewModel {
    func toggleSignIn() {
        self.willSignIn.toggle()
    }
}

extension AuthViewModel {
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
        // ...
        
        guard (validateUserData()) else {
            return
        }
        
        // if succeed
        self.cleanUpInputDatas()
        self.willSignIn = true
    }
}

extension AuthViewModel {
    private func validateUserData() -> Bool {
        guard (input_password_new == input_password_conf) else { return false }
        
        return true
    }
    
    private func requestSignIn() {
        
    }
    
    private func requestSignUp() {
        
    }
}

extension AuthViewModel {
    private func cleanUpInputDatas() {
        self.input_password = ""
        self.input_password_new = ""
        self.input_password_conf = ""
        self.input_name = ""
        self.input_email = ""
    }
}
