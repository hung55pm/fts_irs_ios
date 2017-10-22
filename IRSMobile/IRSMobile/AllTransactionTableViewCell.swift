//
//  AllTransactionTableViewCell.swift
//  IRSMobile
//
//  Created by hungdn on 10/21/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class AllTransactionTableViewCell: UITableViewCell {

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

    let labseries : UILabel = {
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
    let labunitbalace : UILabel = {
        
        let lable = UILabel()
        lable.numberOfLines = 0
        lable.lineBreakMode = .byWordWrapping
        lable.text = "hung 4"

        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    let labamount : UILabel = {
        
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
        labdate.autoSetDimension(.width, toSize: (10*screenSize.width)/100)
        labtran.autoSetDimension(.width, toSize: (14*screenSize.width)/100)
        labseries.autoSetDimension(.width, toSize: (14*screenSize.width)/100)
        
        labamount.autoSetDimension(.width, toSize: (20*screenSize.width)/100)
        labunit.autoSetDimension(.width, toSize: screenSize.width/14)
        labunitbalace.autoSetDimension(.width, toSize: (25*screenSize.width)/100)
        
        print(" screen " + String(describing: (screenSize.width)/12) + "  " + String(describing: (3*screenSize.width)/24) + "   " + String(describing: (5*screenSize.width)/24))
        setupview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupview() {
        let views = ["v0": labdate, "v1": labtran, "v2" : labseries,  "v3" : labamount,  "v4" : labunit, "v5" : labunitbalace]
        
        addSubview(labdate)
        addSubview(labtran)
        addSubview(labseries)
        addSubview(labamount)
        addSubview(labunit)
        addSubview(labunitbalace)
     
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v0]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : labdate]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v1]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1" : labtran]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v2]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v2" : labseries]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v3]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v3" : labamount]))

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v4]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v4" : labunit]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v5]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v5" : labunitbalace]))
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0]-[v1]-[v2]-[v3]-[v4]-[v5]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        
    }

}
