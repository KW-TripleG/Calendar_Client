//
//  LoginView.swift
//  Calendar1
//
//  Created by Coldot on 2022/09/18.
//

import SwiftUI

struct LoginView: View {
    
    @State var input_username: String = ""
    @State var input_password: String = ""
    
    var body: some View {
        VStack {
            Image("TG_Logo")
                .resizable()
                .scaledToFit()
            
            TextField("Username", text: $input_username)
                .padding()
            SecureField("Password", text: $input_password)
                .padding()
            
            Button("Login") {
                
            }
            .padding()
            .background(Color.logoAccentColorLight)
            .foregroundColor(Color.white.opacity(0.9))
            .cornerRadius(5.0)
            
            
            Spacer()
            
            
            Button("Register") {
                
            }
            .padding()
            .foregroundColor(Color.logoAccentColor)
            
        }
        .padding(.horizontal, 5)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
