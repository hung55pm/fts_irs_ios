//
//  ContactInformationViewController.swift
//  IRSMobile
//
//  Created by hungdn on 10/2/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

import Toaster
import LSDialogViewController
class ContactInformationViewController: UIViewController {
    
    @IBOutlet weak var mail_address: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var fax: UITextField!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var bt_update: UIButton!
    
    
    
    let connect = ConnectSv()
    let userdefault = UserDefaults()
    @IBAction func bt_update_contact(_ sender: UIButton) {
        
        connect.getopt(completionHandler: {(otp) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if(otp == "fail"){
                    Toast(text: "Get OTP fail").show()
                }else{
                
                    self.userdefault.set(otp, forKey: "OTP")
                    let dialogViewController: DialogOTPUpdateContactViewController = DialogOTPUpdateContactViewController(nibName:"DialogOTPUpdateContactViewController", bundle: nil)
                    dialogViewController.delegate = self
                    dialogViewController.emails = self.email.text!
                    dialogViewController.inves = self.userdefault.value(forKey: "INVESTOR_ID") as! String
                    dialogViewController.mail_add = self.mail_address.text!
                    dialogViewController.tel = self.phone.text!
                    dialogViewController.faxci = self.fax.text!
                    self.presentDialogViewController(dialogViewController, animationPattern: .slideLeftRight, completion: { () -> Void in })
                }
                
                
            }
        })
        
        /* var inves = userdefault.value(forKey: "INVESTOR_ID") as! String
         var mail_add = mail_address.text
         var tel = phone.text
         var faxci = fax.text
         var emails = email.text
         
         connect.updateContact(investorId: inves, maillingAddress: mail_add!, tel: tel!, Facsimile: faxci!, email: emails!, completionHandler: {(result) in
         
         if(result == 0){
         Toast(text: "Update contact succeed").show()
         self.userdefault.set(mail_add, forKey: "MAILLING_ADDRESS")
         self.userdefault.set(tel, forKey: "TEL")
         self.userdefault.set(faxci, forKey: "FACSIMILE")
         self.userdefault.set(emails, forKey: "EMAIL")
         
         
         }else if(result == 1){
         Toast(text: "An error occurred. Please try again").show()
         }else{
         Toast(text: "Failed to try again ..").show()
         }
         
         })*/
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mail_address.text = userdefault.string(forKey: "MAILLING_ADDRESS")
        phone.text = userdefault.string(forKey: "TEL")
        fax.text = userdefault.string(forKey: "FACSIMILE")
        email.text = userdefault.string(forKey: "EMAIL")
        bt_update.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(title: "Contact Information")
        self.setNavigationBar(title: "Contact Information")
        
    }
    func dismissDialog() {
        self.dismissDialogViewController(LSAnimationPattern.fadeInOut)
    }
    
}
