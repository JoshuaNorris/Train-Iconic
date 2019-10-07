//
//  Exercise.swift
//  The Matrix
//
//  Created by macuser on 9/14/19.
//  Copyright © 2019 JoshuaNorris. All rights reserved.
//

import Foundation
import SQLite

struct User {
    
    private(set) public var firstName: String!
    private(set) public var lastName: String!
    private(set) public var workoutsCompleted: Int!
    
    
    /* All exercises are initialized as not being completed.*/
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.workoutsCompleted = 0
    }
    
    init(firstName: String, lastName: String, workoutsCompleted: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.workoutsCompleted = workoutsCompleted
    }
    
    /* This function just cnanges the completed boolean flag
     when the checkmark button is pressed. I think there might
     be a better way to do this than a mutating function... */
    /*mutating func wasCompleted() {
        self.completed = true
    }*/
    
    static func sqlRowToUser(row: Statement.Element) -> User {
        do {
            let firstName: String = row[0] as! String
            let lastName: String = row[1] as! String
            let workoutsCompleted: Int = Int(row[2] as! Int64)
            return User.init(firstName: firstName, lastName: lastName, workoutsCompleted: workoutsCompleted)
        }
    }
}
    
extension User: Equatable {
    static func == (leftUser: User, rightUser: User) -> Bool {
        return
            leftUser.firstName == rightUser.firstName &&
            leftUser.lastName == rightUser.lastName &&
            leftUser.workoutsCompleted == rightUser.workoutsCompleted
    }
}

extension Exercise {
    static func printUser(user: User) {
        print("First Name: \(user.firstName). Last Name: \(user.lastName). Workouts Completes: \(user.workoutsCompleted).")
    }
}
