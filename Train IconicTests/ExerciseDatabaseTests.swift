//
//  ExerciseDatabaseTests.swift
//  Train IconicTests
//
//  Created by macuser on 10/1/19.
//  Copyright © 2019 JoshuaNorris. All rights reserved.
//

import XCTest
import SQLite
@testable import Train_Iconic

class ExerciseDatabaseTests: XCTestCase {
    
    func testDatabaseCreateTable() {
        var db = ExerciseDatabase.init()
        db.initialize()
        db.dropTable()
        XCTAssert(db.createTable())
        db.dropTable()
    }
    
    func testDatabaseList() {
        var db = ExerciseDatabase.init()
        db.initialize()
        db.dropTable()
        XCTAssert(db.createTable())
        XCTAssert(db.insertNewExercise(title: "Bench", repCount: 5))
        XCTAssert(db.insertNewExercise(title: "Squat", repCount: 6))
        XCTAssert(db.insertNewExercise(title: "Dead Lift", repCount: 7))
        XCTAssert(db.insertNewExercise(title: "Power Clean", repCount: 8))
        let result = db.listExercises()!
        let exercise1 = Exercise.init(title: "Bench", completed: false, repCount: 5)
        let exercise4 = Exercise.init(title: "Power Clean", completed: false, repCount: 8)
        XCTAssert(result[0] == exercise1)
        XCTAssert(result[3] == exercise4)
        XCTAssert(result.count == 4)
        db.dropTable()
    }
    
    func testDatabaseFindExercise() {
        var db = ExerciseDatabase.init()
        db.initialize()
        db.dropTable()
        XCTAssert(db.createTable())
        XCTAssert(db.insertNewExercise(title: "Bench", repCount: 5))
        XCTAssert(db.insertNewExercise(title: "Squat", repCount: 6))
        XCTAssert(db.insertNewExercise(title: "Dead Lift", repCount: 7))
        XCTAssert(db.insertNewExercise(title: "Power Clean", repCount: 8))
        let result = db.findExercise(title: "Dead Lift")
        let exercise = Exercise.init(title: "Dead Lift", completed: false, repCount: 7)
        XCTAssert(result == exercise)
        db.dropTable()
    }
    
    func testDatabaseCompletedExercise() {
        var db = ExerciseDatabase.init()
        db.initialize()
        db.dropTable()
        XCTAssert(db.createTable())
        XCTAssert(db.insertNewExercise(title: "Dead Lift", repCount: 5))
        let exercise = Exercise.init(title: "Dead Lift", completed: true, repCount: 5)
        XCTAssert(db.exerciseWasCompleted(title: "Dead Lift"))
        let result = db.findExercise(title: "Dead Lift")
        XCTAssert(result == exercise)
        db.dropTable()
    }
    
    func testDatabaseSetNotes() {
        var db = ExerciseDatabase.init()
        db.initialize()
        db.dropTable()
        XCTAssert(db.createTable())
        XCTAssert(db.insertNewExercise(title: "Dead Lift", repCount: 5))
        let _ = db.setExerciseNotes(title: "Dead Lift", notes: "This was really hard")
        let exercise = Exercise.init(title: "Dead Lift", completed: true, repCount: 5, notes: "This was really hard.")
        XCTAssert(db.exerciseWasCompleted(title: "Dead Lift"))
        let result = db.findExercise(title: "Dead Lift")
        XCTAssert(result == exercise)
        db.dropTable()
    }
}

