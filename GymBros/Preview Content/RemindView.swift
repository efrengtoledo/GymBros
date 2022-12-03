//
//  RemindView.swift
//  GymBros
//
//  Created by Gabriel Toledo on 12/2/22.
//

import SwiftUI

struct RemindView: View {
    var body: some View {
        VStack {
            DropDownView()
            Spacer()
            Button(action: {
            }) {
                Text("Create").font(.system(size: 20, weight: .medium))
            }
        }.navigationTitle("Remind")
    }
}

struct RemindView_Previews: PreviewProvider {
    static var previews: some View {
        RemindView()
    }
}
