//
//  BankAcountViewController.swift
//  IRSMobile
//
//  Created by hungdn on 10/2/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class BankAcountViewController: UIViewController {

    
    @IBOutlet weak var ben_bank: UITextField!
    @IBOutlet weak var bank_address: UITextField!
    
    @IBOutlet weak var bank_swift: UITextField!
    
    @IBOutlet weak var acount_name: UITextField!
    
    @IBOutlet weak var acount_number: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(title: "Bank Account")
        self.setNavigationBar(title: " Bank Account")
        
    }


}
