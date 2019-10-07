//
//  HomeTabBar.swift
//  Train Iconic
//
//  Created by macuser on 10/2/19.
//  Copyright © 2019 JoshuaNorris. All rights reserved.
//

import UIKit

//@IBDesignable
class HomeTabBar: UITabBar {

    override func awakeFromNib() {
        super.awakeFromNib()
        let homeTab = UITabBarItem(title: "Home", image: UIImage(named: "homeIcon - 20"), tag: 0)
        let workoutTab = UITabBarItem(title: "Workout", image: UIImage(named: "workout icon - 20"), tag: 1)
        let logTab = UITabBarItem(title: "Log", image: UIImage(named: "log Icon - 20"), tag: 2)
        self.setItems([homeTab, workoutTab, logTab], animated: false)
    }
    
    // override func prepareForInterfaceBuilder() {}
    
}
