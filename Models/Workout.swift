//
//  Workout.swift
//  GymBros
//
//  Created by Gabriel Toledo on 12/3/22.
//

import Foundation

struct Workout: Codable {
    let exercise: String
    let setNumber: Int
    let restTime: Int
    let length: Int
    let userID: String
}
