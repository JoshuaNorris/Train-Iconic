import Foundation
import SQLite

struct ExerciseDatabase {
    
    var database: Connection!
    var exercisesTable: Table!
    var workoutCount: String!
    
    let title = Expression<String>("title")
    let completed = Expression<Bool>("completed")
    let repCount = Expression<Int>("repCount")
    let notes = Expression<String>("notes")
    
    // THIS IS TESTED.
    // The test is that the database is created and can be used.
    mutating func initialize() {
        do {
            self.workoutCount = getWorkoutCount()
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("exercises\(self.workoutCount ?? "")").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
            self.exercisesTable = Table("exercises\(self.workoutCount ?? "")")
        } catch {
            print(error)
        }
    }
    
    // THIS IS TESTED
    // The test is whether or not this function throws an error.
    func createTable() -> Bool {
        do {
            try database.execute(
            """
                CREATE TABLE IF NOT EXISTS exercises\(self.workoutCount ?? "")(
            title TEXT UNIQUE,
            completed INT,
            repCount INT,
            notes TEXT);
            """
            )
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    // THIS IS TESTED.
    // The test is whether or not this function throws an error.
    func insertNewExercise(title: String, repCount: Int) -> Bool {
        do {
            try database.execute(
            """
            INSERT INTO exercises\(self.workoutCount ?? "") (title, completed, repCount)
                VALUES( "\(title)", 0, \(repCount));
            """
            )
            return true
        } catch {
            print(error)
            return false
        }
    }
    

    // THIS IS TESTED
    // This tests the correctness of the listing, and the size of the list.
    // This does not test for failures, like if the same exercise is being added
    // to the database twice.
    func listExercises() -> [Exercise]? {
        var result:[Exercise]?
        do {
            result = []
            for row in try database.prepare("SELECT * FROM exercises\(self.workoutCount ?? "")") {
                result!.append(Exercise.sqlRowToExercise(row: row))
            }
            return result
        } catch {
            print(error)
            return result
        }
    }
    
    static func sqlIntToBool(integer: Int64) -> Bool {
        if integer == 0 {
            return false
        } else if integer == 1 {
            return true
        } else {
            print("SOMETHING BAD")
            return false
        }
    }

    // THIS IS TESTED.
    //
    func findExercise(title: String) -> Exercise {
        do {
            var result:[Exercise] = []
            for row in try database.prepare("""
                SELECT * FROM exercises\(self.workoutCount ?? "") WHERE title = "\(title)";
                """) {
                result.append(Exercise.sqlRowToExercise(row: row))
            }
            Exercise.printExercise(exercise: result[0])
            return result[0]
        } catch {
            print(error)
            return Exercise.init(title: "blah", repCount: 1)
        }
    }

    func exerciseWasCompleted(title: String) -> Bool {
        do {
            try database.execute(
                """
                UPDATE exercises\(self.workoutCount ?? "")
                SET completed = 1
                WHERE title = "\(title)";
                """
            )
            return true
        } catch {
            print("ERROR")
            print(error)
            return false
        }
    }
    
    func setExerciseNotes(title: String, notes: String) -> Bool {
        do {
            try database.execute(
                """
                UPDATE exercises\(self.workoutCount ?? "")
                SET notes = "\(notes)"
                WHERE title = "\(title)";
                """
            )
            return true
        } catch {
            print("ERROR")
            print(error)
            return false
        }
    }
    
    func dropTable() {
        do {
            try database.run(exercisesTable.drop(ifExists: true))
        } catch {
            print("COULD NOT DROP TABLE \(error)")
        }
    }
    
    func getWorkoutCount() -> String {
        var UserDB = UserDatabase.init()
        let _ = UserDB.initialize()
        return String(UserDB.getWorkoutsCompleted()!)
    }
}
