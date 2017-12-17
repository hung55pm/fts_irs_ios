//
//  LoginViewController.swift
//  IRSMobile
//
//  Created by Doan Ngoc Hung on 9/17/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit
import Toaster
import SlideMenuControllerSwift

class LoginViewController: UIViewController {
    var ed_user,ed_pass: String?
    let connect = ConnectSv()
    let userdefault = UserDefaults()
    
    @IBOutlet weak var txt_genner: UIButton!
    
    
    @IBOutlet weak var ed_username: UITextField!
    
    @IBAction func bt_general(_ sender: UIButton) {
        let secondViewController:GeneralViewController = GeneralViewController()
        
        self.present(secondViewController, animated: true, completion: nil)
    }
    @IBOutlet weak var remember: UISwitch!
    
    @IBOutlet weak var ed_password: UITextField!
    
    @IBOutlet weak var bt_login_out: UIButton!
    @IBAction func switch_remember(_ sender: UISwitch) {
        if remember.isOn == true{
            userdefault.set(true, forKey: "IS_CHECK_LOGIN")
        }else{
            userdefault.set(false, forKey: "IS_CHECK_LOGIN")
        }
        
        
    }
    @IBAction func bt_login(_ sender: UIButton) {
        ed_user=ed_username.text
        ed_pass=ed_password.text
       
        
         //       let appDelegate = UIApplication.shared.delegate as! AppDelegate
          //     appDelegate.createmenuleft()
       // UIApplication.shared.delegate?.window??.rootViewController = slideMenuController
        
        if(ed_user=="" || ed_pass==""){
            Toast(text: "You must enter full enough information").show()
        }else{
            connect.login(user: ed_user!, pass: ed_pass!,completionHandler: {(result) in
                if(result == 200){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        
                        self.connect.getinfor(user: self.ed_user!, completionHandler: {(results) in
                            if(results == 200){
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                appDelegate.createmenuleft()
                                if self.remember.isOn == true {
                                    self.userdefault.set(true, forKey: "IS_CHECK_LOGIN")
                                } else {
                                    
                                    self.userdefault.set(false, forKey: "IS_CHECK_LOGIN")
                                }
                                }
                            }else{
                                Toast(text: "get info error").show()
                                
                            }
                        
                        })
                        
                    }
                    
                }else if(result == 300){
                    Toast(text: "wrong account or password").show()
                }else{
                    Toast(text: "login fail").show()
                }
                
            })
            
            
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //var time = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        txt_genner.setTitleColor( UIColor(red: 7/255, green: 48/255, blue: 105/255, alpha: 1), for: .normal)
        bt_login_out.layer.cornerRadius = 5
        bt_login_out.setTitleColor( UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        remember.setOn(self.userdefault.value(forKey: "IS_CHECK_LOGIN") as! Bool, animated: true)
        if((self.userdefault.value(forKey: "IS_CHECK_LOGIN") as! Bool)){
            ed_username.text = userdefault.value(forKey: "USERNAME") as! String
            ed_password.text = userdefault.value(forKey: "PASSWORD") as! String
        }
        
        
    
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("111111")
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
