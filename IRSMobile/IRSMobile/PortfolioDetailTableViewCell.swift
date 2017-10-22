//
//  PortfolioDetailTableViewCell.swift
//  IRSMobile
//
//  Created by hungdn on 10/22/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class PortfolioDetailTableViewCell: UITableViewCell {

    let labdate : UILabel = {
        let lable = UILabel()
        lable.text = "hung"
        lable.numberOfLines = 0
        lable.lineBreakMode = .byWordWrapping
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    let labtran : UILabel = {
        let lable = UILabel()
        lable.text = "hung 2"
        lable.numberOfLines = 0
        lable.lineBreakMode = .byWordWrapping
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    let labunit : UILabel = {
        
        let lable = UILabel()
        lable.text = "hung 3"
        lable.numberOfLines = 0
        lable.lineBreakMode = .byWordWrapping
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    let labcredit : UILabel = {
        
        let lable = UILabel()
        lable.numberOfLines = 0
        lable.lineBreakMode = .byWordWrapping
        lable.text = "hung 4"
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    let labmaketvalue : UILabel = {
        
        let lable = UILabel()
        lable.text = "hung 5"
        lable.numberOfLines = 0
        lable.lineBreakMode = .byWordWrapping
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let screenSize = UIScreen.main.bounds
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        labdate.autoSetDimension(.width, toSize: (13*screenSize.width)/100)
        labtran.autoSetDimension(.width, toSize: (23*screenSize.width)/100)
        labunit.autoSetDimension(.width, toSize: (15*screenSize.width)/100)
        labcredit.autoSetDimension(.width, toSize: (15*screenSize.width)/100)
        labmaketvalue.autoSetDimension(.width, toSize: (28*screenSize.width)/100)
        setupview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupview() {
        let views = ["v0": labdate, "v1": labtran, "v2" : labunit,  "v3" : labcredit,  "v4" : labmaketvalue]
        
        addSubview(labdate)
        addSubview(labtran)
        addSubview(labunit)
        addSubview(labcredit)
        addSubview(labmaketvalue)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v0]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : labdate]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v1]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1" : labtran]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v2]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v2" : labunit]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v3]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v3" : labcredit]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v4]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v4" : labmaketvalue]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0]-[v1]-[v2]-[v3]-[v4]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        
    }

}
