//
//  SignInView.swift
//  GymBros
//
//  Created by Gabriel Toledo on 11/1/22.
//

import SwiftUI
import Firebase


struct SignInView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var email = ""
    @State var password = ""
    @State var signInProcessing = false
    @State var signInErrorMessage = ""
    
    var body: some View {
        ZStack {
            Color("SecondaryColor")
                .ignoresSafeArea()
            VStack(spacing: 15) {
                Spacer()
                Text("Gym Bros")
                    .font(.title)
                    .fontWeight(.bold)
                    
                LogoView()
                Spacer()
                SignInCredentialFields(email: $email, password: $password)
                Button(action: {
                    //Sign in user using Firebase
                    signInUser(userEmail: email, userPassword: password)
                }) {
                    Text("Log In")
                        .bold()
                        .frame(width: 360, height: 50)
                        .background(.thinMaterial)
                        .cornerRadius(10)
                }
                .disabled(!signInProcessing && !email.isEmpty && !password.isEmpty ? false : true)
                if signInProcessing {
                    ProgressView()
                }
                if !signInErrorMessage.isEmpty {
                    Text("Failed to sign in: \(signInErrorMessage)")
                        .foregroundColor(.red)
                }
                Spacer()
                HStack {
                    Text("Don't have an account?")
                    Button(action: {
                        viewRouter.currentPage = .signUpPage
                    }) {
                        Text("Sign Up")
                    }
                }
                .opacity(0.9)
            }
            .padding()
        }
    }
    func signInUser(userEmail: String, userPassword: String) {
        signInProcessing = true
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                signInProcessing = false
                signInErrorMessage = error!.localizedDescription
                return
            }
            switch authResult {
            case .none:
                print("Could not sign in user")
                signInProcessing = false
            case .some(_):
                print("User signed in")
                signInProcessing = false
                withAnimation {
                    viewRouter.currentPage = .homePage
                }
            }
        }
    }
   
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

struct SignInCredentialFields: View {
    
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        Group {
            TextField("Email", text: $email)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
                .padding(.bottom, 30)
        }
    }
}
