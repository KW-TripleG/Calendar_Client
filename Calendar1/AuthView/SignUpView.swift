//
//  SignUpView.swift
//  Calendar1
//
//  Created by Coldot on 2022/09/21.
//

import SwiftUI

struct SignUpView: View {
    
    @Binding var isSignIn: Bool
    
    @State private var input_username: String = ""
    @State private var input_password_new: String = ""
    @State private var input_password_conf: String = ""
    @State private var input_email: String = ""
    
    var body: some View {
        ZStack {
            // background layer
            Color.gray
                .opacity(0.075)
                .ignoresSafeArea()
            
            
            // main layer
            VStack {
                Spacer()
                    .frame(height: 15)
                
                HStack {
                    Text("Sign Up")
                        .font(.system(size: 30, weight: .bold))
                    
                    Spacer()
                }
                
                TextField("Username", text: $input_username)
                    .textContentType(.username)
                    .padding()
                    .background(Color.backgroundColor)
                    .cornerRadius(10)
                SecureField("New Password", text: $input_password_new)
                    .textContentType(.newPassword)
                    .padding()
                    .background(Color.backgroundColor)
                    .cornerRadius(10)
                SecureField("Confirm Password", text: $input_password_conf)
                    .textContentType(.password)
                    .padding()
                    .background(Color.backgroundColor)
                    .cornerRadius(10)
                TextField("Email Address", text: $input_email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color.backgroundColor)
                    .cornerRadius(10)
                
                Spacer()
                    .frame(height: 15)
                
                Button(action: {
                    
                }, label: {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                        .background(Color.accentColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                })
                
                
                Spacer()
                
                
                Button("Sign In") {
                    self.isSignIn = true
                }
                .padding()
                
            }
            .padding(EdgeInsets.init(top: 20, leading: 15, bottom: 0, trailing: 15))
        }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}