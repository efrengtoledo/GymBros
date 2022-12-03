//
//  SignUpView.swift
//  AuthenticationStarter
//
//  Created by Work on 13.12.21.
//

import SwiftUI
import Firebase

struct CustomColor {
    static let primaryColor = Color("PrimaryColor")
    static let secondaryColor = Color("SecondaryColor")
}
struct SignUpView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var email = ""
    @State var password = ""
    @State var passwordConfirmation = ""
    @State var signUpErrorMessage = ""
    
    @State var signUpProcessing = false
    var body: some View {
        
        ZStack {
            Color("PrimaryColor")
                .ignoresSafeArea()
            VStack(spacing: 15) {
                Spacer()
                Text("Gym Bros")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(CustomColor.secondaryColor)
                
                
                Spacer()
                
                SignUpCredentialFields(email: $email, password: $password, passwordConfirmation: $passwordConfirmation)
                Button(action: {
                    //Sign up user using Firebase
                    signUpUser(userEmail: email, userPassword: password)
                }) {
                    Text("Sign Up")
                        .bold()
                        .frame(width: 360, height: 50)
                        .background(.thinMaterial)
                        .cornerRadius(10)
                }
                .disabled(!signUpProcessing && !email.isEmpty && !password.isEmpty && !passwordConfirmation.isEmpty && password == passwordConfirmation ? false : true)
                Spacer()
                if signUpProcessing {
                    ProgressView()
                }
                if !signUpErrorMessage.isEmpty {
                    Text("Failed to create account: \(signUpErrorMessage)")
                        .foregroundColor(.red)
                }
                Spacer()
                
                HStack {
                    Text("Already have an account?").foregroundColor(Color.white)
                    Button(action: {
                        viewRouter.currentPage = .signInPage
                    }) {
                        Text("Log In")
                    }
                }
                .opacity(0.9)
            }
            .padding()
        }
            
    }
    func signUpUser(userEmail: String, userPassword: String) {
        signUpProcessing = true
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { authResult, error in
            guard error == nil else {
                signUpErrorMessage = error!.localizedDescription
                signUpProcessing = false
                return
            }
            switch authResult {
            case .none:
                print("Could not Create an Account")
                signUpProcessing = false
            case .some(_):
                print("User Created")
                signUpProcessing = false
                viewRouter.currentPage = .homePage
                
            }
        }
    }
}



struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

struct LogoView: View {
    var body: some View {
        Image("Logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300, height: 150)
            .padding(.top, 70)
    }
}

struct SignUpCredentialFields: View {
    
    @Binding var email: String
    @Binding var password: String
    @Binding var passwordConfirmation: String
    
    var body: some View {
        Group {
            TextField("Email", text: $email)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
            SecureField("Password", text: $password)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
            SecureField("Confirm Password", text: $passwordConfirmation)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
                .border(Color.red, width: passwordConfirmation != password ? 1 : 0)
                .padding(.bottom, 30)
        }
    }
}

