//
//  SignUpView.swift
//  Calendar1
//
//  Created by Coldot on 2022/09/21.
//

import SwiftUI


struct SignUpView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    init(_ viewModel: AuthViewModel) {
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
                
                TextField("Username", text: $viewModel.input_username)
                    .textContentType(.username)
                    .modifier(AuthTextFieldStyle())
                SecureField("New Password", text: $viewModel.input_password_new)
                    .textContentType(.newPassword)
                    .privacySensitive()
                    .modifier(AuthTextFieldStyle())
                SecureField("Confirm Password", text: $viewModel.input_password_conf)
                    .textContentType(.password)
                    .privacySensitive()
                    .modifier(AuthTextFieldStyle())
                TextField("Full Name", text: $viewModel.input_name)
                    .textContentType(.name)
                    .modifier(AuthTextFieldStyle())
                TextField("Email Address", text: $viewModel.input_email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .modifier(AuthTextFieldStyle())
                
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
                .alert("", isPresented: $viewModel.isSignUpSucceed) {
                    Button(action: viewModel.signUpAlertDismissed) {
                        Text("확인")
                            .foregroundColor(.accentColor)
                    }
                } message: {
                    Text("회원가입이 완료되었습니다.")
                }
                
                
                Spacer()
                
                Button(action: viewModel.toggleSignIn) {
                    Text("Sign In")
                        .foregroundColor(Color.accentColor)
                        .padding()
                }
                
            } // VStack
            .padding(EdgeInsets.init(top: 35, leading: 15, bottom: 0, trailing: 15))
            
        } // ZStack
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
      let globalRouter = GlobalRouter()
      AuthView(viewModel: .init(globalRouter: globalRouter))
    }
}
