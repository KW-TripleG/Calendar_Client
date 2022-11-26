//
//  SignUpView.swift
//  Calendar1
//
//  Created by Coldot on 2022/09/21.
//

import SwiftUI

struct AuthTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .padding()
            .background(Color.textFieldColor)
            .cornerRadius(10)
    }
}

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel
    
    init(_ viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }
    
  var body: some View {
    ZStack {
      // background layer
      Color.gray
        .opacity(0.075)
        .ignoresSafeArea()
      
      
      // main layer
      VStack {
        HStack {
          Text("Sign Up")
            .font(.system(size: 30, weight: .bold))
          Spacer()
        }
        
        TextField("Username", text: $viewModel.id)
          .authViewFieldStyle()
          .textContentType(.username)
        SecureField("New Password", text: $viewModel.password)
          .authViewFieldStyle()
          .textContentType(.newPassword)
          .privacySensitive()
        SecureField("Confirm Password", text: $viewModel.passwordConf)
          .authViewFieldStyle()
          .textContentType(.password)
          .privacySensitive()
        TextField("Full Name", text: $viewModel.name)
          .authViewFieldStyle()
          .textContentType(.name)
        TextField("Email Address", text: $viewModel.email)
          .authViewFieldStyle()
          .textContentType(.emailAddress)
          .keyboardType(.emailAddress)
        
        Spacer()
          .frame(height: 15)
        
        Button(action: viewModel.signUpButtonClicked) {
          Text("Submit")
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(Color.accentColor)
            .foregroundColor(Color.white)
            .cornerRadius(10)
        }
        
        Spacer()
        
        Button(action: viewModel.signInButtonTapped) {
          Text("Sign In")
            .foregroundColor(Color.accentColor)
            .padding()
        }
        
      } // VStack
      .padding(EdgeInsets.init(top: 35, leading: 15, bottom: 0, trailing: 15))
      
    } // ZStack
    .alert(self.viewModel.alertMessage, isPresented: $viewModel.isShowingAlert) {
      Button("확인") {
        self.viewModel.alertActionHandler()
      }
    }
  }
}
