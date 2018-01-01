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
class DialogOTPChangePassViewController: UIViewController {
var delegate: ChangePasswordViewController?
    var seconds = 60
    var timer = Timer()
    @IBOutlet weak var txt_countdow: UILabel!
    
    @IBOutlet weak var ed_otp: UITextField!
    
    @IBOutlet weak var txt_noti: UILabel!
    
    @IBOutlet weak var txt_bt_confirm: UIButton!
     var inves : String = ""
    var oldpass: String = ""
    var newpass:String = ""
    var connect = ConnectSv()
    var userdefault = UserDefaults()
    @IBAction func bt_confirm(_ sender: Any) {
        let otp = ed_otp.text
        if(otp == userdefault.value(forKey: "OTP") as! String){
            connect.changpassword(investorId: inves, oldpass: oldpass, newpass: newpass, completionHandler: {(result) in
                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if(result == 0){
                    Toast(text: "Change password succeed").show()
                    self.userdefault.set(self.newpass, forKey: "PASSWORD")
                    
                }else if(result == 1){
                    Toast(text: "InvestorID or Old Password wrong").show()
                }else{
                    Toast(text: "failed to try again ..").show()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        txt_bt_confirm.layer.cornerRadius = 5
        runTimer()

       
    }

    override func viewDidDisappear(_ animated: Bool) {
        finsh()
        print("disable")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
