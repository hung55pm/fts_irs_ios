//
//  SubcriptionTableViewCell.swift
//  IRSMobile
//
//  Created by hungdn on 10/7/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class SubcriptionTableViewCell: UITableViewCell {

    //
    //  RedemptionTableViewCell.swift
    //  IRSMobile
    //
    //  Created by Doan Ngoc Hung on 10/13/17.
    //  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
    //
    
        let labdate : UILabel = {
            let lable = UILabel()
            lable.text = "hung"
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
        let labprice : UILabel = {
            
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
            labdate.autoSetDimension(.width, toSize: screenSize.width/7)
            labseries.autoSetDimension(.width, toSize: (5*screenSize.width)/24)
            labunit.autoSetDimension(.width, toSize: (2*screenSize.width)/22)
            labprice.autoSetDimension(.width, toSize: (3*screenSize.width)/20)
            labamount.autoSetDimension(.width, toSize: (4*screenSize.width)/12)
            setupview()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        func setupview() {
            let views = ["v0": labdate, "v1": labseries, "v2" : labunit,  "v3" : labprice,  "v4" : labamount]
            
            addSubview(labdate)
            addSubview(labseries)
            addSubview(labunit)
            addSubview(labprice)
            addSubview(labamount)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v0]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : labdate]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v1]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1" : labseries]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v2]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v2" : labunit]))
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v3]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v3" : labprice]))
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v4]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v4" : labamount]))
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0]-[v1]-[v2]-[v3]-[v4]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
            
            
        }
        
        
    }

    



