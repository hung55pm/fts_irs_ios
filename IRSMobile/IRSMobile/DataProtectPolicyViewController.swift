//
//  DataProtectPolicyViewController.swift
//  IRSMobile
//
//  Created by hungdn on 12/5/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class DataProtectPolicyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenWidth =  UIScreen.main.bounds.width
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 60))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "Data Protection Policy");
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
