//
//  UserDatabaseTests.swift
//  Train IconicTests
//
//  Created by macuser on 10/1/19.
//  Copyright © 2019 JoshuaNorris. All rights reserved.
//

import XCTest
import SQLite
@testable import Train_Iconic

class UserDatabaseTests: XCTestCase {
    
    func testDatabaseCreateTable() {
        var db = UserDatabase.init()
        XCTAssert(db.initialize())
    }
    
    func testDatabaseInsertName() {
        var db = UserDatabase.init()
        let _ = db.initialize()
        let _ = db.dropTable()
        let _ = db.createTable()
        let _ = db.insertTheUserOnlyOnce()
        XCTAssert(db.insertName(firstName: "Josh", lastName: "Norris"))
        let testCase = User.init(firstName: "Josh", lastName: "Norris")
        XCTAssert(db.listUser()!.firstName == testCase.firstName)
        XCTAssert(db.listUser()!.lastName == testCase.lastName)
        let _ = db.dropTable()
    }
    
    func testDatabaseIncrementWorkout() {
        var db = UserDatabase.init()
        let _ = db.initialize()
        let _ = db.dropTable()
        let _ = db.createTable()
        let _ = db.insertTheUserOnlyOnce()
        let _ = db.insertName(firstName: "Josh", lastName: "Norris")
        XCTAssert(db.incrementWorkoutsCompleted())
        XCTAssert(db.getWorkoutsCompleted()! == 1)
        XCTAssert(db.incrementWorkoutsCompleted())
        XCTAssert(db.getWorkoutsCompleted()! == 2)
        
        let _ = db.dropTable()
    }
    
    func testInsertTheUserOnlyOnce() {
        var db = UserDatabase.init()
        let _ = db.initialize()
        let _ = db.dropTable()
        let _ = db.createTable()
        XCTAssert(db.insertTheUserOnlyOnce())
        XCTAssert(!db.insertTheUserOnlyOnce())
        
        let _ = db.dropTable()
    }
}

