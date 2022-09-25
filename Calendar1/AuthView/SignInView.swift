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
                Spacer()
                    .frame(height: 15)
                
                HStack {
                    Text("Sign In")
                        .font(.system(size: 30, weight: .bold))
                    
                    Spacer()
                }
                
                TextField("Username", text: $input_username)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                SecureField("Password", text: $input_password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                
                Spacer()
                    .frame(height: 15)
                
                Button(action: {
                    
                }, label: {
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                        .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                        .background(Color.accentColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                })
                
                
                Spacer()
                
                
                Button(action: {
                    self.isSignIn = false
                }, label: {
                    Text("Sign Up")
                        .foregroundColor(Color.accentColor)
                        .padding()
                })
                
            }
            .padding(EdgeInsets.init(top: 20, leading: 15, bottom: 0, trailing: 15))
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
