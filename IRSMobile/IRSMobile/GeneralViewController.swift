//
//  GeneralViewController.swift
//  IRSMobile
//
//  Created by hungdn on 12/5/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class GeneralViewController: UIViewController {

    
    @IBAction func bt_forgot(_ sender: Any) {
        let secondfogot: ForgotPasswordViewController = ForgotPasswordViewController()
        self.present(secondfogot, animated: true, completion: nil)
    }

    @IBAction func bt_faqs(_ sender: Any) {
        let secondfogot: FAQsViewController = FAQsViewController()
        self.present(secondfogot, animated: true, completion: nil)
    }
  
    @IBAction func bt_data_policy(_ sender: Any) {
        let secondfogot: DataProtectPolicyViewController = DataProtectPolicyViewController()
        self.present(secondfogot, animated: true, completion: nil)
    }
    
    @IBAction func bt_security(_ sender: Any) {
        let secondfogot: SecurityTipsViewController = SecurityTipsViewController()
        self.present(secondfogot, animated: true, completion: nil)
    }
    
    @IBAction func bt_about(_ sender: Any) {
        let secondfogot: AboutCroweHorwathViewController = AboutCroweHorwathViewController()
        self.present(secondfogot, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenWidth =  UIScreen.main.bounds.width
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 60))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "General information");
        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(named: "arrow_left"), for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn2.addTarget(self, action: "finshview", for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: btn2)
        navItem.leftBarButtonItem = item2
        navBar.setItems([navItem], animated: false);

        // Do any additional setup after loading the view.
    }
    func finshview() {
        self.dismiss(animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   }
