//
//  AuthView.swift
//  Calendar1
//
//  Created by Coldot on 2022/09/24.
//

import SwiftUI

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
