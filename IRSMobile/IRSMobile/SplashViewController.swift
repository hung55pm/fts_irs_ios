//
//  SplashViewController.swift
//  IRSMobile
//
//  Created by hungdn on 10/28/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit
import Toaster


class SplashViewController: UIViewController {
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let userdefault = UserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
          
            self.indicator.stopAnimating()
                if((self.userdefault.value(forKey: "IS_CHECK_LOGIN") as! Bool) == true && (self.userdefault.value(forKey: "INVESTOR_ID")as? String != nil)
                    ){
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.createmenuleft()
                    
                }else{
                    let secondViewController:LoginViewController = LoginViewController()
                    
                    self.present(secondViewController, animated: true, completion: nil)
            }
           
            
        }
        
    
    }

   
    

}
