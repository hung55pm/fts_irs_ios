//
//  DialogOTPLoginViewController.swift
//  IRSMobile
//
//  Created by hungdn on 12/20/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit
import LSDialogViewController

class DialogOTPLoginViewController: UIViewController {
var delegate: LoginViewController?
    var seconds = 180
    var timer = Timer()
    @IBOutlet weak var txt_countdow: UILabel!
    
    @IBOutlet weak var ed_otp: UITextField!
    
    @IBOutlet weak var txt_noti: UILabel!
    
    @IBOutlet weak var txt_bt_confirm: UIButton!
    
    @IBAction func bt_confirm(_ sender: Any) {
        let otp = ed_otp.text
        if(otp == userdefault.value(forKey: "OTP") as! String){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.createmenuleft()
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
    let userdefault = UserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_bt_confirm.layer.cornerRadius = 5
        runTimer()

       
   
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        ed_otp.resignFirstResponder()
    }

    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
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
