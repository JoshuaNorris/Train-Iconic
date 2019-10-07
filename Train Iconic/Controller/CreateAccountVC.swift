//
//  CreateAccountVC.swift
//  The Matrix
//
//  Created by macuser on 9/13/19.
//  Copyright © 2019 JoshuaNorris. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createAccountButtonWasPressed() {
        if firstNameTextField.text != "" && lastNameTextField.text != "" {
            performSegue(withIdentifier: "toHomeTab", sender: .none)
            var userDB = UserDatabase.init()
            userDB.initialize()
            let _ = userDB.createTable()
            let _ = userDB.insertName(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!)
            print(userDB.listUser()!)
        }
    }

}
