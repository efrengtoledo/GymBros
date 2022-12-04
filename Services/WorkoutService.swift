//
//  WorkoutService.swift
//  GymBros
//
//  Created by Gabriel Toledo on 12/3/22.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol WorkoutServiceProtocol {
    func create(_ workout: Workout) -> AnyPublisher<Void, Error>
}

final class WorkoutService: WorkoutServiceProtocol {
    private let db = Firestore.firestore()
    func create(_ workout: Workout) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            do {
                _ = try self.db.collection("workouts").addDocument(from: workout)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}
