//
//  InvestorInfomationViewController.swift
//  IRSMobile
//
//  Created by hungdn on 10/2/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class InvestorInfomationViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var register_address: UITextField!
    
    @IBOutlet weak var date_of_co: UITextField!
    
    @IBOutlet weak var gender: UITextField!
    
    @IBOutlet weak var passport_number: UITextField!
    
    @IBOutlet weak var passport_expridate: UITextField!
    
    @IBOutlet weak var counttry: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.setNavigationBar(title: "Investor Information")
        self.setNavigationBarItem(title: "Investor Information")
        
    }
 
}
