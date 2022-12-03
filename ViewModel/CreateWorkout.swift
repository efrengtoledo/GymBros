//
//  CreateWorkout.swift
//  GymBros
//
//  Created by Gabriel Toledo on 12/2/22.
//

import SwiftUI

final class CreateWorkoutViewModel: ObservableObject {
    @Published var dropdowns: [WorkoutPartViewModel] = [
        .init(type: .exercise),
        .init(type: .setNumber),
        .init(type: .restTimer),
        .init(type: .length)
    ]
    
    enum Action {
        case selectOption(index: Int)
    }
    
    var hasSelectedDropdown: Bool {
        selectedDropdownIndex != nil
    }
    
    var selectedDropdownIndex: Int? {
        dropdowns.enumerated().first(where: {$0.element.isSelected})?.offset
    }
    
    var displayedOptions: [DropdownOptions] {
        guard let selectedDropdownIndex = selectedDropdownIndex else { return [] }
        return dropdowns[selectedDropdownIndex].options
    }
    
    func send(action: Action) {
        switch action {
        case let .selectOption(index):
            guard let selectedDropdownIndex = selectedDropdownIndex else { return }
            clearSelectedOptions()
            dropdowns[selectedDropdownIndex].options[index].isSelected = true
            clearSelectedDropdown()
        }
    }
    func clearSelectedOptions() {
        guard let selectedDropdownIndex = selectedDropdownIndex else { return }
        dropdowns[selectedDropdownIndex].options.indices.forEach { index in
            dropdowns[selectedDropdownIndex].options[index].isSelected = false
        }
    }
    func clearSelectedDropdown() {
        guard let selectedDropdownIndex = selectedDropdownIndex else { return }
        dropdowns[selectedDropdownIndex].isSelected = false
    }
}

extension CreateWorkoutViewModel {
    struct WorkoutPartViewModel: DropdownItemProtocol {
        var options: [DropdownOptions]
            
        var headerTitle: String {
            type.rawValue
        }
        
        var dropdownTitle: String {
            options.first(where: { $0.isSelected })?.formatted ?? ""
        }
        
        var isSelected: Bool = false
        private let type: WorkoutPartType
        
        init(type: WorkoutPartType) {
            switch type {
            case .exercise:
                self.options = ExerciseOptions.allCases.map { $0.toDropdownOptions }
            case .setNumber:
                self.options = SetOptions.allCases.map { $0.toDropdownOptions }
            case .restTimer:
                self.options = RestOptions.allCases.map { $0.toDropdownOptions }
            case .length:
                self.options = LengthOptions.allCases.map { $0.toDropdownOptions }
            }
            self.type = type
            
        }
        
        enum WorkoutPartType: String, CaseIterable {
            case exercise = "Exercise"
            case setNumber = "Number of Sets"
            case restTimer = "Rest Time"
            case length = "Length"
        }
        
        enum ExerciseOptions: String, CaseIterable, DropdownOptionsProtocol {
            case pushups
            case benchpress
            case inclinebench
            case shoulderpress
            case triceppulldown
            case lateralraise
            case dips
            
            var toDropdownOptions: DropdownOptions {
                .init(type: .text(rawValue),
                      formatted: rawValue.capitalized,
                      isSelected: self == .pushups)
            }
        }
        enum SetOptions: Int, CaseIterable, DropdownOptionsProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOptions: DropdownOptions {
                .init(type: .number(rawValue),
                      formatted: "\(rawValue)",
                      isSelected: self == .one)
            }
        }
        enum RestOptions: Int, CaseIterable, DropdownOptionsProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOptions: DropdownOptions {
                .init(type: .number(rawValue),
                      formatted: "\(rawValue) Minutes",
                      isSelected: self == .one)
            }
        }
        enum LengthOptions: Int, CaseIterable, DropdownOptionsProtocol {
            case seven = 7, fourteen = 14, twentyone = 21, twentyeight = 28
            
            var toDropdownOptions: DropdownOptions {
                .init(type: .number(rawValue),
                      formatted: "\(rawValue) Days",
                      isSelected: self == .seven)
            }
        }
    }
}

