//
//  CreateView.swift
//  GymBros
//
//  Created by Gabriel Toledo on 12/2/22.
//

import SwiftUI

struct CreateView: View {
    @StateObject var viewModel = CreateWorkoutViewModel()

    
    var dropdownList: some View {
        Group {
            DropDownView(viewModel: $viewModel.exerciseDropDown)
            DropDownView(viewModel: $viewModel.setNumberDropDown)
            DropDownView(viewModel: $viewModel.restTimerDropDown)
            DropDownView(viewModel: $viewModel.lengthDropDown)
        }
//        ForEach(viewModel.dropdowns.indices, id: \.self) { index in
//            DropDownView(viewModel: $viewModel.dropdowns[index])
//        }
    }

    
    
    var body: some View {
        ScrollView {
            VStack {
                dropdownList
                Spacer()
                    Button(action: {
                        viewModel.send(action: .createWorkout)
                    }) {
                        Text("Create")
                            .font(.system(size: 24,
                                          weight: .medium))
                    }
                               
                .navigationBarTitle("Create")
                .padding(.bottom, 15)
            }
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
