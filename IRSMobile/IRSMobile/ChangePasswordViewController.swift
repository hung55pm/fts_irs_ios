//
//  ChangePasswordViewController.swift
//  IRSMobile
//
//  Created by hungdn on 10/2/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    
    @IBOutlet weak var investor_name: UITextField!
    
    @IBOutlet weak var old_password: UITextField!
    
    @IBOutlet weak var new_password: UITextField!
    
    @IBOutlet weak var confirm_password: UITextField!
    
    @IBAction func bt_confirm(_ sender: UIButton) {
        
    }
    @IBOutlet weak var bt_confirm: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let investor = UserDefaults()
        investor_name.text = investor.string(forKey: "INVESTOR_NAME")
        bt_confirm.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar(title: "Change Password")
        self.setNavigationBarItem(title: "Change Password")
        
    }


}
