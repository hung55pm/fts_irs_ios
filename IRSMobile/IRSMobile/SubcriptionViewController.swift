//
//  SubcriptionViewController.swift
//  IRSMobile
//
//  Created by hungdn on 10/2/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class SubcriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tf_from: UITextField!
        
    @IBOutlet weak var tf_to: UITextField!
    @IBAction func bt_search(_ sender: Any) {
    }
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var total_usd: UILabel!
    
    @IBOutlet weak var total_sgd: UILabel!
    
    var array = [Model_Sucription]()
    let connect = ConnectSv()
    let formats = Format()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.dataSource = self
        self.tableview.delegate = self

        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(title: "Subscription")
        self.setNavigationBar(title: "Subscription")
        let investor = UserDefaults()

        connect.getsubcription(investorID: investor.string(forKey: "INVESTOR_ID")!, stratdate: "1-1-2015", enddate: "10-8-2017", completionHandler: {(result) in
            self.array = result!
//            self.tableview.reloadData()
            print("aaaaa" + String(self.array.count))
            self.tableview.reloadData()
            var total_usd : Float = 0
            var total_sgd :Float = 0
            for item in result!{
                if(item.CURRENCY_ID == "USD"){
                    total_usd = total_usd + item.AMOUNT!
                }else if(item.CURRENCY_ID == "SGD"){
                    total_sgd = total_sgd + item.AMOUNT!
                }
            }
            
            self.total_sgd.text = self.formats.formatpricetocurrency(string1: String(format:"%3.2f", total_sgd))
             self.total_usd.text = self.formats.formatpricetocurrency(string1: String(format:"%3.2f", total_usd))
            
        })

    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SubcriptionTableViewCell", owner: self, options: nil)?.first as! SubcriptionTableViewCell
        if(indexPath.row == 0){
            cell.date.font = cell.date.font.withSize(15)
            cell.series.font = cell.series.font.withSize(15)
            cell.unit.font = cell.unit.font.withSize(15)
            cell.price.font = cell.price.font.withSize(15)
            cell.amount.font = cell.amount.font.withSize(15)
            cell.date.text = "Date"
            cell.series.text = "Classes/Series"
            cell.unit.text = "Unit"
            cell.price.text = "Price"
            cell.amount.text = "Amount"
            
        }else if (indexPath.row > 0){
            cell.date.text = formats.formatdatetoddMMMyyyy(str: array[indexPath.row - 1].DATE!)
            cell.series.text = array[indexPath.row - 1].SHARE_SERIES_NAME
            cell.unit.text = formats.formatpricetocurrency(string1: String(format:"%3.2f", array[indexPath.row - 1].UNIT_PRICE!))
            cell.price.text = formats.formatpricetocurrency(string1:String(format:"%3.2f", array[indexPath.row - 1].QUANTITY!))
            cell.amount.text = formats.formatpricetocurrency(string1:String(format:"%3.2f", array[indexPath.row - 1].AMOUNT!))
        
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.array.count + 1)
    }
    
    
}
