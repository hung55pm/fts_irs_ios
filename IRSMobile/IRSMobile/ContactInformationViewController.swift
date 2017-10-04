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
    @IBOutlet weak var bt_update: UIButton!
    
    @IBAction func bt_update_contact(_ sender: UIButton) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let investor = UserDefaults()
        mail_address.text = investor.string(forKey: "MAILLING_ADDRESS")
        phone.text = investor.string(forKey: "TEL")
        fax.text = investor.string(forKey: "FACSIMILE")
        email.text = investor.string(forKey: "EMAIL")
        bt_update.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(title: "Contact Information")
         self.setNavigationBar(title: "Contact Information")
        
    }

}
