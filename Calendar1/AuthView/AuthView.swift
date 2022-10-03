//
//  AuthView.swift
//  Calendar1
//
//  Created by Coldot on 2022/09/24.
//

import SwiftUI


struct AuthTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .padding()
            .background(Color.backgroundColor)
            .cornerRadius(10)
    }
}


struct AuthView: View {

    @State var isSignIn: Bool = true

    var body: some View {

        if (isSignIn) {
            SignInView(isSignIn: $isSignIn)
        }
        else {
            SignUpView(isSignIn: $isSignIn)
        }

    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
