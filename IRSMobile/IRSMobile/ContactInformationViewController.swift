//
//  ContactInformationViewController.swift
//  IRSMobile
//
//  Created by hungdn on 10/2/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class ContactInformationViewController: UIViewController {
    
    @IBOutlet weak var mail_address: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var fax: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBAction func bt_update_contact(_ sender: UIButton) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(title: "Contact Information")
         self.setNavigationBar(title: "Contact Information")
        
    }

}
