//
//  SignInView.swift
//  Calendar1
//
//  Created by Coldot on 2022/09/21.
//

import SwiftUI

struct SignInView: View {
    
    @Binding var isSignIn: Bool
    
    @State private var input_username: String = ""
    @State private var input_password: String = ""
    
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
                
                TextField("Username", text: $input_username)
                    .padding()
                    .modifier(AuthTextFieldStyle())
                SecureField("Password", text: $input_password)
                    .padding()
                    .privacySensitive()
                    .modifier(AuthTextFieldStyle())
                
                Spacer()
                    .frame(height: 15)
                
                Button(action: {}) {
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color.accentColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Text("Sign Up")
                        .foregroundColor(Color.accentColor)
                        .padding()
                }
                
            }
            .padding(EdgeInsets.init(top: 35, leading: 15, bottom: 0, trailing: 15))
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
