//
//  ChangePasswordViewController.swift
//  IRSMobile
//
//  Created by hungdn on 10/2/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit
import Toaster

import LSDialogViewController
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
               // changpass(inves: userdefault.string(forKey: "INVESTOR_ID")!, oldpass: oldpass!, newpass: newpass!)
                
                 let userID = userdefault.value(forKey: "USERNAME") as! String
                connect.getopt(userID: userID, completionHandler: {(otp) in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        if(otp == "fail"){
                            Toast(text: "Get OTP fail").show()
                        }else{
                            
                            self.userdefault.set(otp, forKey: "OTP")
                            let dialogViewController: DialogOTPChangePassViewController = DialogOTPChangePassViewController(nibName:"DialogOTPChangePassViewController", bundle: nil)
                            dialogViewController.delegate = self
                            dialogViewController.newpass = self.new_password.text!
                            dialogViewController.inves = self.userdefault.value(forKey: "INVESTOR_ID") as! String
                            dialogViewController.oldpass = self.old_password.text!
                            self.presentDialogViewController(dialogViewController, animationPattern: .slideLeftRight, completion: { () -> Void in })
                        }
                        
                        
                    }
                })

            }
        }
        
        
    }
    @IBOutlet weak var bt_confirm: UIButton!
    
    
    let investor = UserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        investor_name.text = investor.string(forKey: "INVESTOR_NAME")
        bt_confirm.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        investor_name.resignFirstResponder()
        old_password.resignFirstResponder()
        new_password.resignFirstResponder()
        confirm_password.resignFirstResponder()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar(title: "Change Password")
        self.setNavigationBarItem(title: "Change Password")
        
    }
    func dismissDialog() {
        self.dismissDialogViewController(LSAnimationPattern.fadeInOut)
    }


}
