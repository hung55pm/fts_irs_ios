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
    
    @IBOutlet weak var ed_username: UITextField!
    
    
    @IBOutlet weak var ed_password: UITextField!
    
    @IBOutlet weak var bt_login_out: UIButton!
    @IBAction func switch_remember(_ sender: UISwitch) {
    }
    @IBAction func bt_login(_ sender: UIButton) {
        ed_user=ed_username.text
        ed_pass=ed_password.text
        
        if(ed_user=="" || ed_pass==""){
            Toast(text: "Ban phai nhap day du thong tin").show()
        }else if(ed_user=="hungdn" && ed_pass=="abc123"){
            
            let secondViewController:MainViewController = MainViewController()
            
            self.present(secondViewController, animated: true, completion: nil)
            
        }else{
            Toast(text: "Username hoac password sai").show()
        }
        
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
