//
//  DialogConvesionShareViewController.swift
//  IRSMobile
//
//  Created by hungdn on 10/28/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class DialogConvesionShareViewController: UIViewController {
    var delegate: AllTransactionViewController?
    var date,tran,point, from,from_unit, from_price,from_amount,to, to_unit,to_price,to_amount : String?
    
    @IBOutlet weak var txt_date: UILabel!
    @IBOutlet weak var txt_tran: UILabel!
    
    @IBOutlet weak var txt_point: UILabel!
    
    @IBOutlet weak var txt_from: UILabel!
    @IBOutlet weak var txt_from_unit: UILabel!
    
    @IBOutlet weak var txt_from_price: UILabel!
    @IBOutlet weak var txt_from_amount: UILabel!
    @IBOutlet weak var txt_to: UILabel!
    @IBOutlet weak var txt_to_unit: UILabel!
    @IBOutlet weak var txt_to_price: UILabel!
    @IBOutlet weak var txt_to_amount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_date.text = date
        txt_tran.text = tran
        txt_point.text = point
        txt_from.text = from
        txt_from_unit.text = from_unit
        txt_from_price.text = from_price
        txt_from_amount.text = from_amount
        txt_to.text = to
        txt_to_unit.text = to_unit
        txt_to_price.text = to_price
        txt_to_amount.text = to_amount

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
