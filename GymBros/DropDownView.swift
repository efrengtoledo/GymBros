//
//  DropDownView.swift
//  GymBros
//
//  Created by Gabriel Toledo on 12/2/22.
//

import SwiftUI

struct DropDownView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Workout")
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
            }.padding(.vertical, 10)
            Button(action: {}) {
                HStack {
                    Text("Push Day")
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 20, weight: .semibold))
                }
                
            }
        }.padding(20)
    }
}

struct DropDownView_Previews: PreviewProvider {
    static var previews: some View {
        DropDownView()
    }
}
