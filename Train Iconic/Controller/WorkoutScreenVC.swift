//
//  WorkoutScreenVC.swift
//  The Matrix
//
//  Created by macuser on 9/13/19.
//  Copyright © 2019 JoshuaNorris. All rights reserved.
//

import UIKit
import SQLite

class WorkoutScreenVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var workoutTable: UITableView!
    
    var exerciseDB: ExerciseDatabase = ExerciseDatabase.init()
    var userDB: UserDatabase = UserDatabase.init()
    
    let usersTable = Table("users")
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let email = Expression<String>("email")
    
    // This function sets this class as the dataSource and delegate for the TableView
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutTable.dataSource = self
        workoutTable.delegate = self
        self.exerciseDB.initialize()
        /**/ exerciseDB.dropTable() /* */
        let _ = exerciseDB.createTable()

        /**/
        for x in DataService.instance.getExercises() {
            let _ = exerciseDB.insertNewExercise(title: x.title, repCount: x.repCount)
        }
        
        self.userDB.initialize()
        let _ = userDB.dropTable()
        let _ = userDB.createTable()
        /**/
    }
    // This function only changes the UI. This gives the number of rows for the Table View.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let exercises = exerciseDB.listExercises()
        if exercises != nil {
            return exercises!.count
        } else {
            print("tableView numberOfRowsInSection error.")
            return 0
        }
    }
    
    // This function only changes the UI. It loads the contents from the Exercises to the TableViewCell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell") as? ExerciseCell {
            let exercises = exerciseDB.listExercises()
            if exercises != nil {
                let exercise = exerciseDB.listExercises()![indexPath.row]
                cell.updateViews(exercise: exercise)
                cell.viewController = self
                return cell
            } else {
                print("listExercises is nil inside of tableView cellForRowAt")
                return ExerciseCell()
            }
        } else {
            return ExerciseCell()
        }
    }
    
    @IBAction func onFinishedButtonPressed() {
        
    }
}
