//
//  MainViewController.swift
//  IRSMobile
//
//  Created by Doan Ngoc Hung on 9/17/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
class MainViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
               //viewController.addLeftBarButtonWithImage(UIImage(named: "hoge")!)
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar(title: "IRSMobile")
        self.setNavigationBarItem(title: "IRSMobile")
      
    }
   

}
