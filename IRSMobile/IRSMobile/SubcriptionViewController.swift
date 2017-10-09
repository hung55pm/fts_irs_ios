//
//  SubcriptionViewController.swift
//  IRSMobile
//
//  Created by hungdn on 10/2/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit
import DatePickerDialog
class SubcriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var bt_txt_search: UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var total_usd: UILabel!
    
    @IBOutlet weak var total_sgd: UILabel!

    @IBAction func txt_from(_ sender: UITextField) {
        datePickerTapped(txt: txt_txt)
    }
  
    @IBAction func txt_to(_ sender: UITextField) {
        datePickerTapped(txt: tf_to)
    }
  
   
    @IBOutlet weak var txt_txt: UITextField!
    @IBOutlet weak var tf_to: UITextField!
    @IBAction func bt_search(_ sender: Any) {
        
        let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        
        let spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
        
        print("ffffff")
        let investor = UserDefaults()
        let start = formats.formatdatetoMMddyyyy(str: txt_txt.text!)
        let end = formats.formatdatetoMMddyyyy(str: tf_to.text!)
        connect.getsubcription(investorID: investor.string(forKey: "INVESTOR_ID")!, stratdate: start, enddate: end, completionHandler: {(result) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.array = result!
                //            self.tableview.reloadData()
                print("aaaaa" + String(self.array.count))
                
                var total_usd : Float = 0
                var total_sgd :Float = 0
                for item in result!{
                    if(item.CURRENCY_ID == "USD"){
                        total_usd = total_usd + item.AMOUNT!
                    }else if(item.CURRENCY_ID == "SGD"){
                        total_sgd = total_sgd + item.AMOUNT!
                    }
                }
                print(total_usd)
                
                self.total_sgd.text = "SGD " + self.formats.formatpricetocurrency(string1: String(format:"%3.2f", total_sgd))
                self.total_usd.text = "USD " + self.formats.formatpricetocurrency(string1: String(format:"%3.2f", total_usd))
                self.tableview.reloadData()
                alertController.dismiss(animated: true, completion: nil);

                
            }

            
        })

    }
 
    
    var array = [Model_Sucription]()
    let connect = ConnectSv()
    let formats = Format()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.dataSource = self
        self.tableview.delegate = self
        bt_txt_search.layer.cornerRadius = 7
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(title: "Subscription")
        self.setNavigationBar(title: "Subscription")
          self.tableview.reloadData()
        
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
            cell.backgroundColor = UIColor.blue
            cell.date.textColor = UIColor.white
            cell.series.textColor = UIColor.white
            cell.unit.textColor = UIColor.white
            cell.price.textColor = UIColor.white
            cell.amount.textColor = UIColor.white
            
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
    
    func datePickerTapped(txt : UITextField) {
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                print(dt)
                txt.text = self.formats.formatdatefromyyyyMMdd(str: String(describing: dt))
            }
        }
    }
}
