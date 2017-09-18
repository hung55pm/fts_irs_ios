//
//  MainViewController.swift
//  IRSMobile
//
//  Created by Doan Ngoc Hung on 9/15/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var ed_username: UITextField!
    
    
    @IBOutlet weak var ed_password: UITextField!
    
    
    @IBAction func login_switch(_ sender: UISwitch) {
    }
    
    
    @IBAction func bt_login(_ sender: UIButton) {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
