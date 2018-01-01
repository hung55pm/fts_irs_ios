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
        let investor = UserDefaults()
        ben_bank.text = investor.string(forKey: "BENEFICIARY_BANK")
        bank_address.text = investor.string(forKey: "BANK_ADDRESS")
        bank_swift.text = investor.string(forKey: "SWIFT_CODE")
        acount_name.text = investor.string(forKey: "ACCOUNT_NAME")
        acount_number.text = investor.string(forKey: "ACCOUNT_NUMBER")
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        ben_bank.resignFirstResponder()
        bank_address.resignFirstResponder()
        bank_swift.resignFirstResponder()
        acount_name.resignFirstResponder()
        acount_number.resignFirstResponder()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(title: "Bank Account")
        self.setNavigationBar(title: " Bank Account")
        
    }


}
