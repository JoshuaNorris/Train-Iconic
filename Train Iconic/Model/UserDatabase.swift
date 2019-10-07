

import Foundation
import SQLite


struct UserDatabase {
    
    var database: Connection!
    
    let userTable = Table("user")
    let firstName = Expression<String>("firstName")
    let lastName = Expression<String>("lastName")
    let dayNumber = Expression<Int>("workoutsCompleted")
    
    // THIS IS TESTED.
    // The test is that the database is created and can be used.
    
    mutating func initialize() -> Bool {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("user").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
            let _ = self.createTable()
            let _ = self.insertTheUserOnlyOnce()
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    // THIS IS TESTED
    // The test is whether or not this function throws an error.
    func createTable() -> Bool {
        do {
            try database.execute(
            """
            CREATE TABLE IF NOT EXISTS user(
            firstName TEXT,
            lastName TEXT,
            workoutsCompleted INT);
            """
            )
            return true
        } catch {
            print("ERROR IN CREATETABLE()")
            print(error)
            return false
        }
    }
    
    // THIS IS TESTED
    // This tests the correctness of the listing, and the size of the list.
    // This does not test for failures, like if the same exercise is being added
    // to the database twice.
    func listUser() -> User? {
        do {
            var rows: [User] = []
            for row in try database.prepare("SELECT * FROM user") {
                rows.append(User.sqlRowToUser(row: row))
            }
            if rows.count > 0 {
                return rows[0]
            } else {
                return nil
            }
        } catch {
            print("ERROR IN LISTUSER()")
            print(error)
            return nil
        }
    }

    func insertName(firstName: String, lastName: String) -> Bool {
        do {
            try database.execute(
            """
            UPDATE user
            SET firstName = "\(firstName)", lastName = "\(lastName)"
            WHERE rowid = 1;
            """
            )
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func incrementWorkoutsCompleted() -> Bool {
        do {
            try database.execute(
                """
                UPDATE user
                SET workoutsCompleted = workoutsCompleted + 1
                WHERE rowid = 1;
                """
            )
            return true
        } catch {
            print("COULD NOT INCREMENT WORKOUTS COMPLETED:")
            print(error)
            return false
        }
    }
    
    func getWorkoutsCompleted() -> Int? {
        return self.listUser()?.workoutsCompleted
    }
    
    func dropTable() -> Bool {
        do {
            try database.run(userTable.drop(ifExists: true))
            return true
        } catch {
            print("COULD NOT DROP TABLE \(error)")
            return false
        }
    }
    
    func insertTheUserOnlyOnce() -> Bool {
        let user = self.listUser()
        if user == nil {
            do {
                try database.execute(
                """
                INSERT INTO user (firstName, lastName, workoutsCompleted)
                    VALUES( "", "", 0);
                """
                )
                return true
            } catch {
                print("Error in insertTheUserOnlyOnce()")
                print(error)
                return false
            }
        } else {
            return false
        }
    }
}
