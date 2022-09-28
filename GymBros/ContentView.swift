//
//  ContentView.swift
//  GymBros
//
//  Created by Gabriel Toledo on 9/28/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Text("GYMBROS")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding()
                    
                Spacer()
                Text("This is gonna be the logo asset")
                    .foregroundColor(Color.white)
                Spacer()
                HStack {
                    Spacer()
                    Text("LOGIN")
                        .foregroundColor(Color.white)
                    Spacer()
                    Text("JOIN")
                        .foregroundColor(Color.white)
                    Spacer()
                }
                    
                   
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
