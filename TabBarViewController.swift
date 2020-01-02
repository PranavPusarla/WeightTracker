//
//  TabBarViewController.swift
//  HelloWorld
//
//  Created by Chandrasekhar pusarla on 12/30/19.
//  Copyright © 2019 Pranav Pusarla. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tab1 = StatsViewController()
        let tabBar1 = UITabBarItem(title: "Progress", image: UIImage(named: "loss-chart.png"), tag:0)
        tab1.tabBarItem = tabBar1
        let tab2 = SetWeightViewController()
        let tabBar2 = UITabBarItem(title: "Set Weight", image:UIImage(named: "calendar.png"), tag:1)
        tab2.tabBarItem = tabBar2
        let tab3 = HomeViewController()
        let tabBar3 = UITabBarItem(title: "Home", image:UIImage(named:"house.png"), tag:2)
        tab3.tabBarItem = tabBar3
        let tab4 = AddWeightViewController()
        let tabBar4 = UITabBarItem(title: "Add Weight", image:UIImage(named: "plus.png"), tag:3)
        tab4.tabBarItem = tabBar4
        self.viewControllers = [tab3, tab4, tab2, tab1]
    }
    
}
