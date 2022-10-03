//
//  AuthViewModel.swift
//  Calendar1
//
//  Created by Coldot on 2022/10/03.
//

import SwiftUI


final class AuthViewModel: ObservableObject {
    @Published private(set) var willSignIn: Bool
    
    @Published var input_username: String = ""
    @Published var input_password: String = ""
    @Published var input_password_new: String = ""
    @Published var input_password_conf: String = ""
    @Published var input_name: String = ""
    @Published var input_email: String = ""
    
    
    init() {
        self.willSignIn = true
    }
}


extension AuthViewModel {
    func toggleSignIn() {
        self.willSignIn.toggle()
    }
}

extension AuthViewModel {
    func signInButtonClicked() {
        // ...
        
        // if succeed
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
