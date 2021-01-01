//
//  ExerciseCell.swift
//  The Matrix
//
//  Created by macuser on 9/14/19.
//  Copyright © 2019 JoshuaNorris. All rights reserved.
//

import UIKit

class ExerciseCell: UITableViewCell {

    @IBOutlet weak var checkmarkImageButton: UIButton!
    @IBOutlet weak var exerciseTitleLabel: UILabel!
    @IBOutlet weak var repCountLabel: UILabel!
    
    var viewController : UIViewController?
    
    var db: ExerciseDatabase = ExerciseDatabase.init()
    
    /* This function simply makes it where if the cell is selected
     nothing will happen, and the button does not dim after it is
     pressed. */
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.checkmarkImageButton.adjustsImageWhenDisabled = false
        self.db.initialize()
    }
    
    /* This function is constantly updating the cell based on the
     data service. */
    func updateViews(exercise: Exercise) {
        updateCheckmarkButton(isCompleted: exercise.completed)
        self.exerciseTitleLabel.text = exercise.title
        if exercise.repCount != nil {
            self.repCountLabel.text = "Reps: " + String(exercise.repCount!)
        }
    }
    
    /* This function updates the data service then updates the button
     when the checkmark button is pressed. */
    @IBAction func checkmarkButtonWasPressed() {
        showAndHandleNotesPopup()
        setExerciseAsCompleted()
        updateCheckmarkButton(isCompleted: true)
    }
    
    func showAndHandleNotesPopup() {
        let alert = UIAlertController(title: "Add Notes", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Notes"
        })
        
        let action = UIAlertAction(title: "Done", style: .default) { (_) in
            self.setExerciseNotes(notes: alert.textFields!.first!.text!)
        }
        alert.addAction(action)
        self.viewController?.present(alert, animated: true, completion: nil)
    }
    
    
    /* This function goes through every exercise in the dataService and changes the
    completed boolean if the titles match.
    THIS FUNCTION ASSUMES ALL EXERCISE TITLES IN THE WORKOUT ARE DIFFERENT. */
    func setExerciseAsCompleted() {
        db.exerciseWasCompleted(title: exerciseTitleLabel.text!)
    }
    
    func setExerciseNotes(notes: String) {
        print(notes)
        db.setExerciseNotes(title: exerciseTitleLabel.text!, notes: notes)
    }
    
    // This function updates the checkmark image based on whether the exercise has been completed.
    // It changes the image and either enables or disables the button. When the exercise has been
    // completed, we want the button to be disabled.
    func updateCheckmarkButton(isCompleted: Bool) {
        if isCompleted {
            checkmarkImageButton.setBackgroundImage(UIImage(named: "Chalk Check - 60"), for: .normal)
            checkmarkImageButton.isEnabled = false
        } else {
            checkmarkImageButton.setBackgroundImage(UIImage(named: "Chalk Square - 60"), for: .normal)
            checkmarkImageButton.isEnabled = true
        }
    }

}
