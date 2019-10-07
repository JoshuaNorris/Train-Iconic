//
//  Exercise.swift
//  The Matrix
//
//  Created by macuser on 9/14/19.
//  Copyright © 2019 JoshuaNorris. All rights reserved.
//

import Foundation
import SQLite

struct Exercise {
    
    /* The repcount is set as an optional right now, because
     I thought there might be a situation in which this is not
     determined before hand.
     Also this might need to be a String that way something like
     "8-12" could be possible. */
    private(set) public var title: String!
    private(set) public var completed: Bool!
    private(set) public var repCount: Int!
    private(set) public var notes: String?
    
    
    /* All exercises are initialized as not being completed.*/
    init(title: String, repCount: Int) {
        self.title = title
        self.completed = false
        self.repCount = repCount
    }
    
    init(title: String, completed: Bool, repCount: Int) {
        self.title = title
        self.completed = completed
        self.repCount = repCount
    }
    
    init(title: String, completed: Bool, repCount: Int, notes: String) {
        self.title = title
        self.completed = completed
        self.repCount = repCount
        self.notes = notes
    }
    
    /* This function just cnanges the completed boolean flag
     when the checkmark button is pressed. I think there might
     be a better way to do this than a mutating function... */
    mutating func wasCompleted() {
        self.completed = true
    }
    
    static func sqlRowToExercise(row: Statement.Element) -> Exercise {
        do {
            let title: String = row[0] as! String
            let completed: Bool = ExerciseDatabase.sqlIntToBool(integer: row[1] as! Int64)
            let repCount: Int = Int(row[2] as! Int64)
            return Exercise.init(title: title, completed: completed, repCount: repCount)
        }
    }
}
    
extension Exercise: Equatable {
    static func == (leftExercise: Exercise, rightExercise: Exercise) -> Bool {
        return
            leftExercise.title == rightExercise.title &&
                leftExercise.completed == rightExercise.completed &&
                leftExercise.repCount == rightExercise.repCount
    }
}

extension Exercise {
    static func printExercise(exercise: Exercise) {
        print("Title: \(String(describing: exercise.title)). Completed: \(String(describing: exercise.completed)). repCount: \(String(describing: exercise.repCount))")
    }
}
