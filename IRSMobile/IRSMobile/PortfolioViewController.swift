//
//  PortfolioViewController.swift
//  IRSMobile
//
//  Created by hungdn on 10/2/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController {
    var sub: subcriptionview!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sub = subcriptionview(frame: CGRect.zero)
                self.view.addSubview(sub)
        
                // AutoLayout
                sub.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        // Do any additional setup after loading the view.

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(title: "Portfolio")
           self.setNavigationBar(title: "Portfolio")
    }

}
