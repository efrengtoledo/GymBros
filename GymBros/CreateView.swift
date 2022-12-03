//
//  CreateView.swift
//  GymBros
//
//  Created by Gabriel Toledo on 12/2/22.
//

import SwiftUI

struct CreateView: View {
    @State private var isActive = false
    var body: some View {
        ScrollView {
            VStack {
                DropDownView()
                DropDownView()
                DropDownView()
                DropDownView()
                Spacer()
                NavigationLink(destination: RemindView(), isActive: $isActive) {
                    Button(action: {
                        isActive = true
                    }) {
                        Text("Next").font(.system(size: 20, weight: .medium))
                    }
                }.navigationBarTitle("Create")
            }
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
