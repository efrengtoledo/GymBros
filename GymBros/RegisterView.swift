//
//  RegisterView.swift
//  GymBros
//
//  Created by Gabriel Toledo on 10/12/22.
//

import SwiftUI
struct RegisterView: View {
    var state: String
    @State private var username: String = ""
    @State private var password: String = ""
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    Text("\(state)").foregroundColor(Color.white)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    Spacer()
                    Form {
                        TextField(text: $username, prompt: Text("Email")) {
                            Text("EMAIL")
                        }
                        TextField(text: $password, prompt: Text("Password")) {
                            Text("PASS")
                        }
                    }
                    Text("JOIN").foregroundColor(Color.white)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                }
            }
        }
    }
}
