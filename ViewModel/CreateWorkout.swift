//
//  CreateWorkout.swift
//  GymBros
//
//  Created by Gabriel Toledo on 12/2/22.
//

import SwiftUI
import Combine

typealias UserID = String

final class CreateWorkoutViewModel: ObservableObject {
    @Published var exerciseDropDown = WorkoutPartViewModel(type: .exercise)
    @Published var setNumberDropDown = WorkoutPartViewModel(type: .setNumber)
    @Published var restTimerDropDown = WorkoutPartViewModel(type: .restTimer)
    @Published var lengthDropDown = WorkoutPartViewModel(type: .length)
    
    private let userService: UserServiceProtocol
    private let workoutService: WorkoutServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    enum Action {
        case createWorkout
    }

    init(
        userService: UserServiceProtocol = UserService(),
        workoutService: WorkoutServiceProtocol = WorkoutService()
    ) {
        self.userService = userService
        self.workoutService = workoutService
    }
    
    func send(action: Action) {
        switch action {
        case .createWorkout:
            currentUserID().flatMap { userID -> AnyPublisher<Void, Error> in
                return self.createWorkout(userID: userID)
                
            }
                .sink { completion in
                switch completion {
                case let .failure(error):
                    print(error.localizedDescription)
                case .finished:
                    print("Completed")
                }
            } receiveValue: { _ in
                print("Success")
            }.store(in: &cancellables)
        }
    }
    private func createWorkout(userID: UserID) -> AnyPublisher<Void, Error> {
        guard let exercise = exerciseDropDown.text,
              let setAmount = setNumberDropDown.number,
              let restTime = restTimerDropDown.number,
              let length = lengthDropDown.number else {
            return Fail(error: NSError()).eraseToAnyPublisher()
        }
        let workout = Workout(
            exercise: exercise,
            setNumber: setAmount,
            restTime: restTime,
            length: length,
            userID: userID
        )
        return workoutService.create(workout).eraseToAnyPublisher()
    }
    
    private func currentUserID() -> AnyPublisher<UserID, Error> {
        print("Getting UID")
        return userService.currentUser().flatMap { user -> AnyPublisher<UserID, Error> in
            if let UserID = user?.uid {
                print("The User is logged in")
                return Just(UserID)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } else {
                print("User is not logged in")
                return self.userService
                    .signInAnonymously()
                    .map { $0.uid }
                    .eraseToAnyPublisher()
            }
            
        }.eraseToAnyPublisher()
    }
}

extension CreateWorkoutViewModel {
    struct WorkoutPartViewModel: DropdownItemProtocol {
        var selectedOption: DropdownOptions
        
        var options: [DropdownOptions]
            
        var headerTitle: String {
            type.rawValue
        }
        
        var dropdownTitle: String {
            selectedOption.formatted
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
            self.selectedOption = options.first!
            
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
                      formatted: rawValue.capitalized
                )
            }
        }
        enum SetOptions: Int, CaseIterable, DropdownOptionsProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOptions: DropdownOptions {
                .init(type: .number(rawValue),
                      formatted: "\(rawValue)"
                )
            }
        }
        enum RestOptions: Int, CaseIterable, DropdownOptionsProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOptions: DropdownOptions {
                .init(type: .number(rawValue),
                      formatted: "\(rawValue) Minutes"
                )
            }
        }
        enum LengthOptions: Int, CaseIterable, DropdownOptionsProtocol {
            case seven = 7, fourteen = 14, twentyone = 21, twentyeight = 28
            
            var toDropdownOptions: DropdownOptions {
                .init(type: .number(rawValue),
                      formatted: "\(rawValue) Days"
                )
            }
        }
    }
}

extension CreateWorkoutViewModel.WorkoutPartViewModel {
    var text: String? {
        if case let .text(text) = selectedOption.type {
            return text
        }
        return nil
    }
    var number: Int? {
        if case let .number(number) = selectedOption.type {
            return number
        }
        return nil
    }
}

