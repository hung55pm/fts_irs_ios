//
//  ChangePasswordViewController.swift
//  IRSMobile
//
//  Created by hungdn on 10/2/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit
import Toaster


class ChangePasswordViewController: UIViewController {
    
    
    @IBOutlet weak var investor_name: UITextField!
    
    @IBOutlet weak var old_password: UITextField!
    
    @IBOutlet weak var new_password: UITextField!
    
    @IBOutlet weak var confirm_password: UITextField!
    
    var connect = ConnectSv()
    var userdefault = UserDefaults()
    
    @IBAction func bt_confirm(_ sender: UIButton) {
        
        let oldpass = old_password.text
        let newpass = new_password.text
        let confirmpass = confirm_password.text
        
        if(oldpass! == "" || newpass! == "" || confirmpass! == ""){
            Toast(text: "You must enter full enough info").show()
        }else{
            if(newpass != confirmpass){
                Toast(text :"New Password and confirmation passwords are not matchers").show()
            }else{
                changpass(inves: userdefault.string(forKey: "INVESTOR_ID")!, oldpass: oldpass!, newpass: newpass!)
            }
        }
        
        
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
    func changpass(inves: String, oldpass: String, newpass: String){
        connect.changpassword(investorId: inves, oldpass: oldpass, newpass: newpass, completionHandler: {(result) in
            if(result == 0){
                Toast(text: "Change password succeed").show()

            }else if(result == 1){
                Toast(text: "InvestorID or Old Password wrong").show()
            }else{
                Toast(text: "failed to try again ..").show()
            }
            
        })

    }

}
