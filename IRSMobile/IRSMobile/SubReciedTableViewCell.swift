//
//  SubReciedTableViewCell.swift
//  IRSMobile
//
//  Created by hungdn on 12/10/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class SubReciedTableViewCell: UITableViewCell {

    @IBOutlet weak var txt_dealing_date: UILabel!
    
    @IBOutlet weak var txt_date_recived: UILabel!
    
    @IBOutlet weak var txt_series: UILabel!
    
    @IBOutlet weak var txt_amount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
