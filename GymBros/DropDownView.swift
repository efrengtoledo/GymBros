//
//  DropDownView.swift
//  GymBros
//
//  Created by Gabriel Toledo on 12/2/22.
//

import SwiftUI

struct DropDownView<T: DropdownItemProtocol>: View {
    @Binding var viewModel: T
    
    var actionSheet: ActionSheet {
        ActionSheet(
            title: Text("Select"),
            buttons: viewModel.options.map { option in
                return .default(
                    Text(option.formatted)) {
                    // Select Option at button
                        viewModel.selectedOption = option
                }
            }
        )
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.headerTitle)
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
            }.padding(.vertical, 10)
            Button(action: {
                viewModel.isSelected = true
            }) {
                HStack {
                    Text(viewModel.dropdownTitle)
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 20, weight: .semibold))
                }
                
            }
        }
        .actionSheet(isPresented: $viewModel.isSelected) {
            actionSheet
           
        }
        .padding(20)
    }
}

//struct DropDownView_Previews: PreviewProvider {
//    static var previews: some View {
//        DropDownView()
//    }
//}
