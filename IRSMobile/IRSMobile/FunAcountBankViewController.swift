//
//  FunAcountBankViewController.swift
//  IRSMobile
//
//  Created by hungdn on 12/6/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class FunAcountBankViewController: UIViewController {

    @IBOutlet weak var txt_intermediary: UITextField!
    @IBOutlet weak var txt_ben_bank: UITextField!
    @IBOutlet weak var txt_ben_bank_bic: UITextField!
    @IBOutlet weak var txt_ben_acount_name: UITextField!
    
    @IBOutlet weak var ben_acount_number: UITextField!
    
    let ben_bank = UserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()

        txt_intermediary.text = ben_bank.value(forKey: "INTERMEDIATE_BANK") as! String
        txt_ben_bank.text = ben_bank.value(forKey: "BENEFICIARY_BANK") as! String
        txt_ben_bank_bic.text = ben_bank.value(forKey: "BENEFICIARY_BANK_BIC") as! String
        txt_ben_acount_name.text = ben_bank.value(forKey: "BENEFICIARY_ACCOUNT_NAME") as! String
        ben_acount_number.text = ben_bank.value(forKey: "BENEFICIARY_ACCOUNT_NUMBER") as! String
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        txt_ben_bank.resignFirstResponder()
        txt_ben_bank_bic.resignFirstResponder()
        txt_intermediary.resignFirstResponder()
        txt_ben_acount_name.resignFirstResponder()
        ben_acount_number.resignFirstResponder()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar(title: "Bank Acount")
        self.setNavigationBarItem(title: "Bank Acount")
        
        
    }
}
