//
//  Workout.swift
//  The Matrix
//
//  Created by macuser on 9/14/19.
//  Copyright © 2019 JoshuaNorris. All rights reserved.
//

import Foundation
import SQLite

struct Workout {
    
    private(set) public var title: String!
    private(set) public var completed: Bool!
    private(set) public var dayNumber: Int!
    private(set) public var weekNumber: Int!
    private(set) public var dateCompleted: Date?
    private(set) public var notes: String?
    
    
    
    init(title: String, dayNumber: Int, weekNumber: Int) {
        self.title = title
        self.completed = false
        self.dayNumber = dayNumber
        self.weekNumber = weekNumber
    }
    
    init(title: String, completed: Bool, dayNumber: Int, weekNumber: Int) {
        self.title = title
        self.completed = completed
        self.dayNumber = dayNumber
        self.weekNumber = weekNumber
    }
    
    init(title: String, completed: Bool, dayNumber: Int, weekNumber: Int, dateCompleted: Date, notes: String) {
        self.title = title
        self.completed = completed
        self.dayNumber = dayNumber
        self.weekNumber = weekNumber
        self.dateCompleted = dateCompleted
        self.notes = notes
    }
    
    mutating func wasCompleted() {
        self.completed = true
    }
    
    static func sqlRowToWorkout(row: Statement.Element) -> Workout {
        do {
            let title: String = row[0] as! String
            let completed: Bool = ExerciseDatabase.sqlIntToBool(integer: row[1] as! Int64)
            let dayNumber: Int = Int(row[2] as! Int64)
            let weekNumber: Int = Int(row[3] as! Int64)
            let dateCompleted: Date? = row[4] as? Date
            let notes: String? = row[5] as? String
            
            if dateCompleted == nil {
                return Workout.init(title: title, completed: completed, dayNumber: dayNumber, weekNumber: weekNumber)
            } else {
                return Workout.init(title: title, completed: completed, dayNumber: dayNumber, weekNumber: weekNumber, dateCompleted: dateCompleted!, notes: notes!)
            }
        }
    }
}
    
extension Workout: Equatable {
    static func == (leftWorkout: Workout, rightWorkout: Workout) -> Bool {
        return
            leftWorkout.title == rightWorkout.title &&
                leftWorkout.completed == rightWorkout.completed &&
                leftWorkout.dayNumber == rightWorkout.dayNumber &&
                leftWorkout.weekNumber == rightWorkout.weekNumber &&
                leftWorkout.dateCompleted == rightWorkout.dateCompleted &&
                leftWorkout.notes == rightWorkout.notes
    }
}

extension Workout {
    static func printExercise(workout: Workout) {
        print("Title: \(workout.title). Completed: \(workout.completed). Day Number: \(workout.dayNumber). Week Number: \(workout.weekNumber). Date Completed: \(workout.dateCompleted). Notes: \(workout.notes).")
    }
}
