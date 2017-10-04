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
        let investor = UserDefaults()
        let format = Format()
        name.text = investor.string(forKey: "INVESTOR_NAME")
        register_address.text = investor.string(forKey: "REGISTERED_ADDRESS")
         date_of_co.text = format.formatdatetoddMMMyyyy(str: investor.string(forKey: "DATE_OF_BIRTH")!)
         gender.text = investor.string(forKey: "GENDER_ID")
         passport_number.text = investor.string(forKey: "PASSPORT_ID")
         passport_expridate.text = format.formatdatetoddMMMyyyy(str: investor.string(forKey: "EXPIRY_DATE")!)
         counttry.text = investor.string(forKey: "NATIONALITY_ID")
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.setNavigationBar(title: "Investor Information")
        self.setNavigationBarItem(title: "Investor Information")
        
    }
 
}
