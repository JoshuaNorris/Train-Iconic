//
//  GetStartedButton.swift
//  The Matrix
//
//  Created by macuser on 9/12/19.
//  Copyright © 2019 JoshuaNorris. All rights reserved.
//

import UIKit

@IBDesignable
class MainLargeButton: UIButton {
    
    /* This class is being called for the following buttons:
     "GET STARTED!" from FirstTimeVC
     "CREATE ACCOUNT!" from CreateAccountVC. */
    
    /* This function changes how the button looks at runtime. */
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeButton()
    }
    
    /* This function changes how the button looks for the storyboard. */
    override func prepareForInterfaceBuilder() {
        customizeButton()
    }
    
    /* This makes the button have rounded edges. */
    func customizeButton() {
        self.layer.cornerRadius = 10.0
    }

}
