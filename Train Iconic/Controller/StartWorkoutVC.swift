//
//  StartWorkoutVC.swift
//  Train Iconic
//
//  Created by macuser on 10/2/19.
//  Copyright © 2019 JoshuaNorris. All rights reserved.
//

import UIKit

class StartWorkoutVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startWorkoutWasPressed() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeTabVC: UITabBarController = mainStoryboard.instantiateViewController(identifier: "HomeTabVC")
        
        var db = UserDatabase.init()
        db.initialize()
        db.userIsStartingWorkout()
        homeTabVC.viewDidLoad()
        performSegue(withIdentifier: "fromStartWorkoutToHomeTab", sender: nil)
        
    }

}
