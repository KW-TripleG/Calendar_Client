//
//  SignInView.swift
//  Calendar1
//
//  Created by Coldot on 2022/09/21.
//

import SwiftUI


struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel
    
    init(_ viewModel: SignInViewModel) {
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
                    Text("Sign In")
                        .font(.system(size: 30, weight: .bold))
                    Spacer()
                }
                
                TextField("ID", text: $viewModel.id)
                    .authViewFieldStyle()
                    .textContentType(.username)
                SecureField("Password", text: $viewModel.password)
                    .authViewFieldStyle()
                    .textContentType(.password)
                    .privacySensitive()
                
                Spacer()
                    .frame(height: 15)
                
                Button(action: viewModel.signInButtonTapped) {
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color.accentColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
                
                
                Spacer()
                
                Button(action: viewModel.signUpButtonTapped) {
                    Text("Sign Up")
                        .foregroundColor(Color.accentColor)
                        .padding()
                }
                
            } // VStack
            .padding(EdgeInsets.init(top: 35, leading: 15, bottom: 0, trailing: 15))
            .alert(self.viewModel.alertMessage, isPresented: self.$viewModel.isShowingAlert) {
              Button("확인", role: .cancel) { }
                .foregroundColor(Color.accentColor)
            }
        }
    }
}
