//
//  DataService.swift
//  The Matrix
//
//  Created by macuser on 9/14/19.
//  Copyright © 2019 JoshuaNorris. All rights reserved.
//

import Foundation

class DataService {
    
    /* This makes one instance of this class that can be updated
     at any place in the application.*/
    static var instance = DataService()

    /* This is a set list for now. Once the Core Data gets built up
     I suspect this might turn into a SQL select statement (or whatever
     the core data equivalent is. */
    private var exercises: [Exercise] = [
        Exercise(title: "A1. BB Deadlift", repCount: 3),
        Exercise(title: "A2. Single led RDL", repCount: 3),
        Exercise(title: "A3. Jump Squats", repCount: 3),
        Exercise(title: "A4. Russian Twists", repCount: 3),
        Exercise(title: "B1. Goblet Squats", repCount: 3),
        Exercise(title: "B2. Single leg Squat", repCount: 3),
        Exercise(title: "B3. GHR crunch", repCount: 3),
    ]
    
    /* This simply returns the exercise list. */
    func getExercises() -> [Exercise] {
        return exercises
    }
    
    /* This is the function that changes the completed flag
    for the ExerciseCell class. */
    func exerciseCompleted(index: Int) {
        exercises[index].wasCompleted()
    }
}
