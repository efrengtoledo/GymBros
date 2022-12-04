//
//  GymBrosApp.swift
//  GymBros
//
//  Created by Gabriel Toledo on 9/28/22.
//

import SwiftUI
import Firebase


@main
struct GymBrosApp: App {
    @StateObject var viewRouter = ViewRouter()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MotherView().environmentObject(viewRouter)
        }
    }
}
