//
//  DialogOTPLoginViewController.swift
//  IRSMobile
//
//  Created by hungdn on 12/20/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit
import LSDialogViewController
import Toaster
class DialogOTPUpdateContactViewController: UIViewController {
var delegate: ContactInformationViewController?
    var seconds = 60
    var timer = Timer()
    @IBOutlet weak var txt_countdow: UILabel!
    
    @IBOutlet weak var ed_otp: UITextField!
    
    @IBOutlet weak var txt_noti: UILabel!
    
    @IBOutlet weak var txt_bt_confirm: UIButton!
    let connect = ConnectSv()
    var inves : String = ""
    var mail_add : String = ""
    var tel: String = ""
    var faxci:String = ""
    var emails: String = ""
    @IBAction func bt_confirm(_ sender: Any) {
        let otp = ed_otp.text
        if(otp == userdefault.value(forKey: "OTP") as! String){
            connect.updateContact(investorId: inves, maillingAddress: mail_add, tel: tel, Facsimile: faxci, email: emails, completionHandler: {(result) in
                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if(result == 0){
                    Toast(text: "Update contact succeed").show()
                    self.userdefault.set(self.mail_add, forKey: "MAILLING_ADDRESS")
                    self.userdefault.set(self.tel, forKey: "TEL")
                    self.userdefault.set(self.faxci, forKey: "FACSIMILE")
                    self.userdefault.set(self.emails, forKey: "EMAIL")
                    
                    
                }else if(result == 1){
                    Toast(text: "An error occurred. Please try again").show()
                    
                }else{
                    Toast(text: "Failed to try again ..").show()
                    
                }
                    
                    self.timer.invalidate()
                    self.delegate?.dismissDialog()
                }
            })
        }else if(otp == ""){
            txt_noti.isHidden = false
            txt_noti.text = "You have not entered the code otp"
           
        }else{
            txt_noti.isHidden = false
            txt_noti.text = "OTP code is incorrect"
            
        }
        
        
    }
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        
    }
    @objc func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        txt_countdow.text = "\(seconds)" //This will update the label.
        finsh()
        
    }
    func finsh() {
        if(seconds == 0){
           timer.invalidate()
            self.delegate?.dismissDialog()
            
        }
    }
    func dissmisdialog() {
        timer.invalidate()
        self.delegate?.dismissDialog()
    }
    let userdefault = UserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_bt_confirm.layer.cornerRadius = 5
        runTimer()

       
    }

    override func viewDidDisappear(_ animated: Bool) {
        finsh()
        print("disable")
    }
    

}
