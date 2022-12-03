//
//  HomePage.swift
//  GymBros
//
//  Created by Gabriel Toledo on 11/1/22.
//

import SwiftUI
import Firebase

import SwiftUI

struct HomeView: View {
    @State var signOutProcessing = false
    @State private var isActive = false
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        
        ZStack {
            NavigationView {
                NavigationLink(destination:
                                CreateView(), isActive: $isActive) {
                    Button(action: {
                        isActive = true
                    }) {
                        Text("Create Workout")
                    }
                }
                    .navigationTitle("GymBros")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            if signOutProcessing {
                                ProgressView()
                            } else {
                                Button("Sign Out") {
                                    signOutUser()
                                }
                            }
                        }
                    }
            }
        }
    }
    func signOutUser() {
        signOutProcessing = true
        let fireBaseAuth = Auth.auth()
        do {
            try fireBaseAuth.signOut()
        }   catch let signOutError as NSError {
            print("Error Signing Out: %@", signOutError)
        }
        withAnimation {
            viewRouter.currentPage = .signInPage
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
