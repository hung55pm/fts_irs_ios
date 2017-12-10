//
//  FundContactViewController.swift
//  IRSMobile
//
//  Created by hungdn on 12/6/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class FundContactViewController: UIViewController {
    
    @IBOutlet weak var txt_fundid: UITextField!
    @IBOutlet weak var txt_fundname: UITextField!
    
    @IBOutlet weak var txt_address: UILabel!
    
    @IBOutlet weak var txt_fax: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    
    @IBOutlet weak var txt_phone: UITextField!
    let investor = UserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_address.layer.borderWidth = 1
        let colormy = UIColor.black
        txt_address.layer.borderColor = colormy.cgColor
        txt_address.layer.cornerRadius = 3
        txt_address.numberOfLines = 0
       
        
        txt_fundid.text = investor.value(forKey: "ORGANIZATION_ID") as! String
        txt_fundname.text = investor.value(forKey: "ORGANIZATION_NAME") as! String
        txt_address.text = investor.value(forKey: "ADDRESS") as! String
        txt_email.text = investor.value(forKey: "FUND_EMAIL_ENOVESTOR") as! String
        txt_fax.text = investor.value(forKey: "FUND_FAX") as! String
        txt_phone.text = investor.value(forKey: "FUND_TEL") as! String

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar(title: "Contact Information")
        self.setNavigationBarItem(title: "Contact Information")
        
        
    }

}
