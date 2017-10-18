//
//  RedemptionViewController.swift
//  IRSMobile
//
//  Created by hungdn on 10/2/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit
import DatePickerDialog
class RedemptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var txt_to: UITextField!
    @IBOutlet weak var txt_from: UITextField!
    @IBAction func bt_from(_ sender: UITextField) {
        datePickerTapped(txt: txt_from)
    }
    
    @IBAction func bt_to(_ sender: UITextField) {
        datePickerTapped(txt: txt_to)
    }
    
    @IBOutlet weak var txt_search: UIButton!
    
    @IBAction func bt_search(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        
        let spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
        
        let investor = UserDefaults()
        let start = formats.formatdatetoMMddyyyy(str: txt_from.text!)
        let end = formats.formatdatetoMMddyyyy(str: txt_to.text!)
        getdata(start: start, end: end, InvestorID: investor.string(forKey: "INVESTOR_ID")!, alertController: alertController)
    }
    
    @IBOutlet weak var lbl_usd: UILabel!
    
    @IBOutlet weak var lbl_sgd: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    var cells : RedemptionTableViewCell!
    
    var array = [Model_Redemption]()
    let connect = ConnectSv()
    let formats = Format()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.dataSource = self
        self.tableview.delegate = self
        tableview.register(RedemptionTableViewCell.self, forCellReuseIdentifier: "redempcell")
        txt_search.layer.cornerRadius = 7
        txt_from.text = formats.getfirstdayofmounth()
        txt_to.text = formats.getdaynow()
        let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        
        let spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
        
        let investor = UserDefaults()
        let start = formats.formatdatetoMMddyyyy(str: formats.getfirstdayofmounth())
        let end = formats.formatdatetoMMddyyyy(str: formats.getdaynow())
        getdata(start: start, end: end, InvestorID: investor.string(forKey: "INVESTOR_ID")!, alertController: alertController)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(title: "Redemption")
        self.setNavigationBar(title: "Redemption")
        self.tableview.reloadData()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.array.count + 1)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cells = tableview.dequeueReusableCell(withIdentifier: "redempcell", for: indexPath) as! RedemptionTableViewCell
        if(indexPath.row == 0){
            
            
            cells.labdate.font = cells.labdate.font.withSize(15)
            cells.labseries.font = cells.labseries.font.withSize(15)
            cells.labunit.font = cells.labunit.font.withSize(15)
            cells.labprice.font = cells.labprice.font.withSize(15)
            cells.labamount.font = cells.labamount.font.withSize(15)
            cells.labdate.text = "Date"
            cells.labseries.text = "Classes/Series"
            cells.labseries.numberOfLines = 0
            cells.labseries.lineBreakMode = .byWordWrapping
            cells.labunit.text = "Unit"
            cells.labprice.text = "Price"
            cells.labamount.text = "Amount"
            cells.backgroundColor = UIColor.blue
            cells.labdate.textColor = UIColor.white
            cells.labseries.textColor = UIColor.white
            cells.labunit.textColor = UIColor.white
            cells.labprice.textColor = UIColor.white
            cells.labamount.textColor = UIColor.white
            
        }else if (indexPath.row > 0){
            
            cells.labdate.font = cells.labdate.font.withSize(13)
            cells.labseries.font = cells.labseries.font.withSize(13)
            cells.labunit.font = cells.labunit.font.withSize(13)
            cells.labprice.font = cells.labprice.font.withSize(13)
            cells.labamount.font = cells.labamount.font.withSize(13)
            cells.labdate.text = formats.formatdatetoddMMMyyyy(str: array[indexPath.row - 1].DATE!)
           cells.labseries.text = array[indexPath.row - 1].SHARE_SERIES_NAME
            cells.labunit.text = formats.formatpricetocurrency(string1: String(format:"%3.2f", array[indexPath.row - 1].UNIT_PRICE!))
            cells.labprice.text = formats.formatpricetocurrency(string1:String(format:"%3.2f", array[indexPath.row - 1].QUANTITY!))
            cells.labamount.text = formats.formatpricetocurrency(string1:String(format:"%3.2f", array[indexPath.row - 1].AMOUNT!))
            
        }
        
        return cells
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
    func getdata(start:String, end: String, InvestorID: String,alertController : UIAlertController ) {
        connect.getredemption(investorID: InvestorID , stratdate: start, enddate: end, completionHandler: {(result) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if(result?.count != 0){
                    self.array = result!
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
                    
                    self.lbl_sgd.text = "SGD " + self.formats.formatpricetocurrency(string1: String(format:"%3.2f", total_sgd))
                    self.lbl_usd.text = "USD " + self.formats.formatpricetocurrency(string1: String(format:"%3.2f", total_usd))
                    self.tableview.reloadData()
                    alertController.dismiss(animated: true, completion: nil);
                    
                    
                }else{
                    self.array = result!
                    var total_usd : Float = 0
                    var total_sgd :Float = 0
                    self.lbl_sgd.text = "SGD " + self.formats.formatpricetocurrency(string1: String(format:"%3.2f", total_sgd))
                    self.lbl_usd.text = "USD " + self.formats.formatpricetocurrency(string1: String(format:"%3.2f", total_usd))
                    self.tableview.reloadData()
                    alertController.dismiss(animated: true, completion: nil);
                    
                    
                }
                
            }
            
            
        })
 
    }
    
}
