//
//  subcriptionview.swift
//  IRSMobile
//
//  Created by hungdn on 10/17/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class subcriptionview: UIView {
    
    var shouldSetupConstraints = true
    var from: UILabel!
    var to: UILabel!
    var txt_from: UITextField!
    var txt_to : UITextField!
    var bt : UIButton!
    var tableview : UITableView!
    var total_usd : UILabel!
    var total_sgd : UILabel!
    var value_usd : UILabel!
    var value_sgd : UILabel!
    
    let screenSize = UIScreen.main.bounds
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        from = UILabel(frame: CGRect.zero)
        to = UILabel(frame: CGRect.zero)
        txt_from = UITextField(frame: CGRect.zero)
        txt_to = UITextField(frame: CGRect.zero)
        from.autoSetDimension(.width, toSize: (1*screenSize.width)/10)
        
        txt_from.autoSetDimension(.width, toSize: (3*screenSize.width)/10)
        to.autoSetDimension(.width, toSize: (1*screenSize.width)/10)
        txt_to.autoSetDimension(.width, toSize: (3*screenSize.width)/10)
        from.text = "from"
        to.text = "to"
        self.addSubview(from)
        self.addSubview(to)
        self.addSubview(txt_from)
        self.addSubview(txt_to)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        let views = ["v0": from, "v1": txt_from, "v2" : to,  "v3" : txt_to] as [String : Any]
        if(shouldSetupConstraints) {
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-60-[v0]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : from]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-60-[v1]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1" : from]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-60-[v2]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v2" : from]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-60-[v3]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v3" : from]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0]-[v1]-[v2]-[v3]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
            
            shouldSetupConstraints = false
        }
        
        super.updateConstraints()
    }
    
    
}
