//
//  PortfolioViewController.swift
//  IRSMobile
//
//  Created by hungdn on 10/2/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit
import DatePickerDialog


class PortfolioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var txt_date: UITextField!
    
  
    
    @IBAction func choose_date(_ sender: UITextField) {
        
        datePickerTapped(txt: txt_date)
    }
    @IBOutlet weak var txt_detail: UIButton!
    
    
    @IBAction func bt_detail(_ sender: UIButton) {
        if(FLAG == false){
            array_detail = [Model_Portfolio_detail]()
            FLAG=true
            
           
            var data_detail = investor.value(forKey: "MOVEMENT") as? [[String:Any]]
            for pd in (data_detail?.reversed())!{
                let model = Model_Portfolio_detail()
                model.DEALING_DATE = pd["DEALING_DATE"] as? String
                model.TRAN_TYPE_NAME = pd["TRAN_TYPE_NAME"] as? String
                model.QUANTITY = pd["QUANTITY"] as? Float
                model.EQUALISATION_CONTIGENT = pd["EQUALISATION_CONTIGENT"] as? Float
                model.MARKET_VALUE = pd["MARKET_VALUE"] as? Float
                
                array_detail.append(model)
                self.tableview.reloadData()
                
            }
            txt_detail.setTitle("Back", for: .normal)
            
        }else{
        
            let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
            
            let spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            
            spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
            spinnerIndicator.color = UIColor.black
            spinnerIndicator.startAnimating()
            
            alertController.view.addSubview(spinnerIndicator)
            self.present(alertController, animated: false, completion: nil)
             let date = formats.formatdatetoMMddyyyy(str: txt_date.text!)
            getdata(date: date, investorId: investor.string(forKey: "INVESTOR_ID")!, alertController: alertController)
            self.tableview.reloadData()
            txt_detail.setTitle("Detail", for: .normal)
        }
        
    }
  
    
    
    var FLAG : Bool = false
    var array = [Model_Portfolio]()
    var array_detail = [Model_Portfolio_detail]()
    let connect = ConnectSv()
    let formats = Format()
    let investor = UserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableview.dataSource = self
        tableview.delegate = self
        tableview.estimatedRowHeight = 30
        tableview.rowHeight = UITableViewAutomaticDimension
        let is_qualision = investor.integer(forKey: "IS_EQUALISATION")
        
        txt_detail.setTitleColor( UIColor(red: 7/255, green: 48/255, blue: 105/255, alpha: 1), for: .normal)
        // Do any additional setup after loading the view.

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(title: "Portfolio")
           self.setNavigationBar(title: "Portfolio")
        

        let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        
        let spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
        txt_date.text = formats.getdaynow()
        let date = formats.formatdatetoMMddyyyy(str: formats.getdaynow())

        getdata(date: date, investorId: investor.string(forKey: "INVESTOR_ID")!, alertController: alertController)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(FLAG == false){
         let cells = Bundle.main.loadNibNamed("PortTableViewCell", owner: self, options: nil)?.first as! PortTableViewCell
            if(indexPath.row % 2 == 0){
                cells.backgroundColor = UIColor(colorLiteralRed: 207/255, green: 207/255, blue: 207/255, alpha: 1)
            }
            cells.txt_series.text = array[indexPath.row].SERIES_CLASS
            cells.txt_unit.text = formats.formatpricetocurrency(string1: String(format:"%3." + investor.string(forKey: "QUANTITY_ROUNDING")! + "f", array[indexPath.row ].UNIT_PRICE!))
            cells.txt_price.text = formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", array[indexPath.row].QUANTITY!))
            cells.txt_market_value.text = formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", array[indexPath.row].MARKET_VALUE!))
//        if(indexPath.row == 0){
//            
//            
//            cells.labseries.font = cells.labseries.font.withSize(13)
//            cells.labunit.font = cells.labunit.font.withSize(13)
//            cells.labprice.font = cells.labprice.font.withSize(13)
//            cells.labmaketvalue.font = cells.labmaketvalue.font.withSize(13)
//
//            cells.labseries.text = "Classes/Series"
//            cells.labunit.text = "Outstanding Unit"
//            cells.labprice.text = "Price"
//            cells.labmaketvalue.text = "Market value"
//            cells.backgroundColor = UIColor.blue
//
//            cells.labseries.textColor = UIColor.white
//            cells.labunit.textColor = UIColor.white
//            cells.labprice.textColor = UIColor.white
//            cells.labmaketvalue.textColor = UIColor.white
//            
//        }else if (indexPath.row > 0){
//            
//            cells.labseries.font = cells.labseries.font.withSize(13)
//            cells.labunit.font = cells.labunit.font.withSize(13)
//            cells.labprice.font = cells.labprice.font.withSize(13)
//            cells.labmaketvalue.font = cells.labmaketvalue.font.withSize(13)
//            cells.labseries.text = array[indexPath.row - 1].SERIES_CLASS
//            cells.labunit.text = formats.formatpricetocurrency(string1: String(format:"%3." + investor.string(forKey: "QUANTITY_ROUNDING")! + "f", array[indexPath.row - 1].UNIT_PRICE!))
//            cells.labprice.text = formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", array[indexPath.row - 1].QUANTITY!))
//            cells.labmaketvalue.text = formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", array[indexPath.row - 1].MARKET_VALUE!))
//            
//            }
            
            return cells
        }else{
             let cell = Bundle.main.loadNibNamed("PortCreditTableViewCell", owner: self, options: nil)?.first as!
            PortCreditTableViewCell
            if(indexPath.row % 2 == 0){
                cell.backgroundColor = UIColor(colorLiteralRed: 207/255, green: 207/255, blue: 207/255, alpha: 1)
            }
            cell.txt_date.text = formats.formatdatetoddMMMyyyy(str: array_detail[indexPath.row].DEALING_DATE!)
            cell.txt_unit.text = formats.formatpricetocurrency(string1: String(format:"%3." + investor.string(forKey: "QUANTITY_ROUNDING")! + "f", array_detail[indexPath.row].QUANTITY!))
            cell.txt_tran.text = array_detail[indexPath.row].TRAN_TYPE_NAME
            cell.txt_credit.text = formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "QUANTITY_ROUNDING")! + "f", array_detail[indexPath.row].EQUALISATION_CONTIGENT!))
            cell.txt_maket_value.text = formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", array_detail[indexPath.row].MARKET_VALUE!))
//            if(indexPath.row == 0){
//                
//                
//                cell.labdate.font = cells.labseries.font.withSize(13)
//                cell.labunit.font = cells.labunit.font.withSize(13)
//                cell.labtran.font = cells.labprice.font.withSize(13)
//                cell.labcredit.font = cells.labprice.font.withSize(13)
//                cell.labmaketvalue.font = cells.labmaketvalue.font.withSize(13)
//                
//                cell.labdate.text = "Date"
//                cell.labunit.text = "Unit"
//                cell.labtran.text = "Transaction"
//                cell.labcredit.text = "Equalisation Credit"
//                cell.labmaketvalue.text = "Market value"
//                cell.backgroundColor = UIColor.blue
//                
//                cell.labdate.textColor = UIColor.white
//                cell.labunit.textColor = UIColor.white
//                cell.labtran.textColor = UIColor.white
//                cell.labcredit.textColor = UIColor.white
//                cell.labmaketvalue.textColor = UIColor.white
//                
//            }else if (indexPath.row > 0){
//                
//                cell.labdate.font = cells.labseries.font.withSize(13)
//                cell.labunit.font = cells.labunit.font.withSize(13)
//                cell.labtran.font = cells.labprice.font.withSize(13)
//                cell.labcredit.font = cells.labprice.font.withSize(13)
//                cell.labmaketvalue.font = cells.labmaketvalue.font.withSize(13)
//                cell.labdate.text = formats.formatdatetoddMMMyyyy(str: array_detail[indexPath.row - 1].DEALING_DATE!)
//                cell.labunit.text = formats.formatpricetocurrency(string1: String(format:"%3." + investor.string(forKey: "QUANTITY_ROUNDING")! + "f", array_detail[indexPath.row - 1].QUANTITY!))
//                cell.labtran.text = array_detail[indexPath.row - 1].TRAN_TYPE_NAME
//                cell.labcredit.text = formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "QUANTITY_ROUNDING")! + "f", array_detail[indexPath.row - 1].EQUALISATION_CONTIGENT!))
//                cell.labmaketvalue.text = formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", array_detail[indexPath.row - 1].MARKET_VALUE!))
//                
//            }
            return cell

        }
        
        

        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(FLAG == false){
            return 120.0
        }else{
            return 170.0
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(FLAG == false){
        return (self.array.count)
        }else{
        return (self.array_detail.count)
        }
    }
    
    func datePickerTapped(txt : UITextField) {
        DatePickerDialog().show("Select date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                print(dt)
                txt.text = self.formats.formatdatefromyyyyMMdd(str: String(describing: dt))
            }
        }

    }
    func getdata(date: String, investorId: String, alertController : UIAlertController) {
        connect.getportfolio(investorID: investorId, date : date, completionHandler: {(result) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                var credit: Float = 0
                if((result?.count)!>0){
                    var data_detail = self.investor.value(forKey: "MOVEMENT") as? [[String:Any]]
                    for pd in data_detail!{
                        credit = credit + (pd["EQUALISATION_CONTIGENT"] as! Float)
                    }
                    var total_usd : Float = 0
                    var total_sgd :Float = 0
                    for item in result!{
                        if(item.CURRENCY_ID == "USD"){
                            total_usd = total_usd + item.MARKET_VALUE!
                        }else if(item.CURRENCY_ID == "SGD"){
                            total_sgd = total_sgd + item.MARKET_VALUE!
                        }
                    }
                    print(total_usd)
                    
                   
                    self.array = result!
                    
                    self.tableview.reloadData()
                    alertController.dismiss(animated: true, completion: nil);
                }else{
                  
                    self.tableview.reloadData()
                    alertController.dismiss(animated: true, completion: nil);
                }
                
                
                
            }
            
            
        })
        
    }

}
