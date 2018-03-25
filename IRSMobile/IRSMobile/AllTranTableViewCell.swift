//
//  AllTranTableViewCell.swift
//  IRSMobile
//
//  Created by Doan Ngoc Hung on 10/24/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class AllTranTableViewCell: UITableViewCell {
    
    @IBOutlet weak var txt_date: UILabel!
    
    @IBOutlet weak var txt_trantype: UILabel!
    
    @IBOutlet weak var txt_series: UILabel!

    @IBOutlet weak var txt_unit: UILabel!
    @IBOutlet weak var txt_unit_balance: UILabel!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
