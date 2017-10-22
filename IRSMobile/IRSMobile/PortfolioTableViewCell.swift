//
//  PortfolioTableViewCell.swift
//  IRSMobile
//
//  Created by hungdn on 10/22/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class PortfolioTableViewCell: UITableViewCell {

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
    let labprice : UILabel = {
        
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
        labseries.autoSetDimension(.width, toSize: screenSize.width/6)
        labunit.autoSetDimension(.width, toSize: (5*screenSize.width)/24)
        labprice.autoSetDimension(.width, toSize: screenSize.width/4)
        labmaketvalue.autoSetDimension(.width, toSize: screenSize.width/4)
        setupview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupview() {
        let views = ["v1": labseries, "v2" : labunit,  "v3" : labprice,  "v4" : labmaketvalue]
        
        addSubview(labseries)
        addSubview(labunit)
        addSubview(labprice)
        addSubview(labmaketvalue)
   
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v1]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1" : labseries]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v2]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v2" : labunit]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v3]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v3" : labprice]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v4]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v4" : labmaketvalue]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v1]-[v2]-[v3]-[v4]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        
    }

}
