//
//  SignInView.swift
//  Calendar1
//
//  Created by Coldot on 2022/09/21.
//

import SwiftUI


struct SignInView: View {
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
                    Text("Sign In")
                        .font(.system(size: 30, weight: .bold))
                    Spacer()
                }
                
                TextField("Username", text: $viewModel.username)
                    .authViewFieldStyle()
                    .textContentType(.username)
                SecureField("Password", text: $viewModel.password)
                    .authViewFieldStyle()
                    .textContentType(.password)
                    .privacySensitive()
                
                Spacer()
                    .frame(height: 15)
                
                Button(action: viewModel.signInButtonClicked) {
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color.accentColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
                
                
                Spacer()
                
                Button(action: viewModel.toggleSignIn) {
                    Text("Sign Up")
                        .foregroundColor(Color.accentColor)
                        .padding()
                }
                
            } // VStack
            .padding(EdgeInsets.init(top: 35, leading: 15, bottom: 0, trailing: 15))
            
        } // ZStack
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
      let globalRouter = GlobalRouter()
      AuthView(viewModel: .init(globalRouter: globalRouter))
    }
}
