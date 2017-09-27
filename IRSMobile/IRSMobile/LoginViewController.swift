//
//  LoginViewController.swift
//  IRSMobile
//
//  Created by Doan Ngoc Hung on 9/17/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit
import Toaster


class LoginViewController: UIViewController {
    var ed_user,ed_pass: String?
    let connect = ConnectSv()
    
    @IBOutlet weak var ed_username: UITextField!
    
    
    @IBOutlet weak var ed_password: UITextField!
    
    @IBOutlet weak var bt_login_out: UIButton!
    @IBAction func switch_remember(_ sender: UISwitch) {
    }
    @IBAction func bt_login(_ sender: UIButton) {
        ed_user=ed_username.text
        ed_pass=ed_password.text
        let secondViewController:MainViewController = MainViewController()
        self.present(secondViewController, animated: true, completion: nil)
        
        
        
//        if(ed_user=="" || ed_pass==""){
//            Toast(text: "You must enter full enough information").show()
//        }else{
//            connect.login(user: ed_user!, pass: ed_pass!,completionHandler: {(result) in
//                if(result == 200){
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                        let secondViewController:ViewController = ViewController()
//                        
//                        self.present(secondViewController, animated: true, completion: nil)
//                    }
//                   
//                }else if(result == 300){
//                     Toast(text: "wrong account or password").show()
//                }else{
//                    Toast(text: "login fail").show()
//                }
//            
//            })
//            
//            
//            
//        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    bt_login_out.layer.cornerRadius = 5

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
