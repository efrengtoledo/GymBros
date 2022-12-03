//
//  CreateView.swift
//  GymBros
//
//  Created by Gabriel Toledo on 12/2/22.
//

import SwiftUI

struct CreateView: View {
    @StateObject var viewModel = CreateWorkoutViewModel()
    @State private var isActive = false
    var dropdownList: some View {
        ForEach(viewModel.dropdowns.indices, id: \.self) { index in
            DropDownView(viewModel: $viewModel.dropdowns[index])
        }
        
    }
    var body: some View {
        ScrollView {
            VStack {
                dropdownList
                Spacer()
                NavigationLink(destination: RemindView(), isActive: $isActive) {
                    Button(action: {
                        isActive = true
                    }) {
                        Text("Next").font(.system(size: 20, weight: .medium))
                    }
                }
                .actionSheet(isPresented: Binding<Bool>(get: {
                    viewModel.hasSelectedDropdown
                }, set: { _ in }), content: { () -> ActionSheet in
                    ActionSheet(title: Text("Select"),
                                buttons: viewModel.displayedOptions.indices.map { index in
                        let option = viewModel.displayedOptions[index]
                        return ActionSheet.Button.default(Text(option
                            .formatted)) {
                            viewModel.send(action: .selectOption(index: index))
                        }
                        
                        
                    })
                })
                .navigationBarTitle("Create")
            }
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
