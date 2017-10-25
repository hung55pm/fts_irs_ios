//
//  DialogSubViewController.swift
//  IRSMobile
//
//  Created by hungdn on 10/25/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class DialogSubViewController: UIViewController {
    var delegate: SubcriptionViewController?
    var date,series, unit,price, amount, tran : String?
    
    @IBOutlet weak var txt_date: UILabel!
    
    @IBOutlet weak var txt_tran: UILabel!
    
    @IBOutlet weak var txt_series: UILabel!
    
    @IBOutlet weak var txt_unit: UILabel!
    
    @IBOutlet weak var txt_price: UILabel!
    
    @IBOutlet weak var txt_amount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txt_date.text = date
        txt_series.text = series
        txt_unit.text = unit
        txt_price.text = price
        txt_amount.text = amount
        txt_tran.text = tran
        
        // Do any additional setup after loading the view.
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
