//
//  DialogAllTranViewController.swift
//  IRSMobile
//
//  Created by hungdn on 10/25/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class DialogAllTranViewController: UIViewController {

    var delegate: AllTransactionViewController?
    @IBOutlet weak var txt_date: UILabel!
    @IBOutlet weak var txt_tran: UILabel!
    @IBOutlet weak var txt_series: UILabel!
    @IBOutlet weak var txt_unit: UILabel!
    @IBOutlet weak var txt_qty: UILabel!
    @IBOutlet weak var txt_unit_balance: UILabel!
    @IBOutlet weak var txt_amount: UILabel!
    
    var date,tran, qty,series, unit,unit_balance, amount : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        txt_date.text = date
        txt_tran.text = tran
        txt_series.text = series
        txt_unit.text = unit
        txt_qty.text = qty
        txt_unit_balance.text = unit_balance
        txt_amount.text = amount
        
        
        
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
