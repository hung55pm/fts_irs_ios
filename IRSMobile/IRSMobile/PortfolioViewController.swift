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
            let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
            
            let spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            
            spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
            spinnerIndicator.color = UIColor.black
            spinnerIndicator.startAnimating()
            
            alertController.view.addSubview(spinnerIndicator)
            self.present(alertController, animated: false, completion: nil)
            let date = formats.formatdatetoMMddyyyy(str: txt_date.text!)
            getdatacredit(date: date, investorId: investor.string(forKey: "INVESTOR_ID")!, alertController: alertController)
            
            
            txt_detail.setTitle("Back", for: .normal)
          FLAG = true
            
        }else if(FLAG == true){
        
            let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
            
            let spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            
            spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
            spinnerIndicator.color = UIColor.black
            spinnerIndicator.startAnimating()
            
            alertController.view.addSubview(spinnerIndicator)
            self.present(alertController, animated: false, completion: nil)
             let date = formats.formatdatetoMMddyyyy(str: txt_date.text!)
            getdata(date: date, investorId: investor.string(forKey: "INVESTOR_ID")!, alertController: alertController)
            txt_detail.setTitle("Detail", for: .normal)
           
            FLAG = false
        }
        print(String(FLAG) + "  tach   ")

        
    }
  
    
    
    
    var FLAG : Bool = false
    var array = [Model_Portfolio]()
    var array_detail = [Model_Portfolio_detail]()
    let connect = ConnectSv()
    let formats = Format()
    let investor = UserDefaults()
    let control_until = Control_until()
    var arrayView = [UIView]()
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
            print("tach" + String(describing: array[indexPath.row].SERIES_CLASS!))
         let cells = Bundle.main.loadNibNamed("PortTableViewCell", owner: self, options: nil)?.first as! PortTableViewCell
            if(indexPath.row % 2 == 0){
                cells.backgroundColor = UIColor(colorLiteralRed: 207/255, green: 207/255, blue: 207/255, alpha: 1)
            }
            cells.txt_series.text = array[indexPath.row].SERIES_CLASS!
            cells.txt_unit.text = formats.formatpricetocurrency(string1: String(format:"%3." + investor.string(forKey: "QUANTITY_ROUNDING")! + "f", array[indexPath.row ].UNIT_PRICE!))
            cells.txt_price.text = formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", array[indexPath.row].QUANTITY!))
            cells.txt_market_value.text = array[indexPath.row].CURRENCY_ID! + " " + formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", array[indexPath.row].MARKET_VALUE!))
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
            cell.txt_maket_value.text = array_detail[indexPath.row].CURRENCY_ID! + " " + formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", array_detail[indexPath.row].MARKET_VALUE!))
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
            return 155.0
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
                if(self.FLAG == true){
                    let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
                    
                    let spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
                    
                    spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
                    spinnerIndicator.color = UIColor.black
                    spinnerIndicator.startAnimating()
                    
                    alertController.view.addSubview(spinnerIndicator)
                    self.present(alertController, animated: false, completion: nil)
                    let date = self.formats.formatdatetoMMddyyyy(str: self.txt_date.text!)
                    self.array_detail = []
                    self.getdatacredit(date: date, investorId: self.investor.string(forKey: "INVESTOR_ID")!, alertController: alertController)
                    
                    
                    //self.txt_detail.setTitle("Back", for: .normal)
                    self.FLAG = true
                    
                }else if(self.FLAG == false){
                    
                    let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
                    
                    let spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
                    
                    spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
                    spinnerIndicator.color = UIColor.black
                    spinnerIndicator.startAnimating()
                    
                    alertController.view.addSubview(spinnerIndicator)
                    self.present(alertController, animated: false, completion: nil)
                    let date = self.formats.formatdatetoMMddyyyy(str: self.txt_date.text!)
                    self.array = []
                    self.getdata(date: date, investorId: self.investor.string(forKey: "INVESTOR_ID")!, alertController: alertController)
                    //self.txt_detail.setTitle("Detail", for: .normal)
                    
                    self.FLAG = false
                }

            }
        }

    }
    func getdata(date: String, investorId: String, alertController : UIAlertController) {
        if(self.arrayView.count > 0){
            for i in 0..<self.arrayView.count{
                let v = self.arrayView[i].viewWithTag(i)
                v?.removeFromSuperview()
                
            }
        }
        connect.getportfolio(investorID: investorId, date : date, completionHandler: {(result) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                var credit: Float = 0
                if((result?.count)!>0){
                   // self.arrayView.removeAll()
                    var data_detail = self.investor.value(forKey: "MOVEMENT") as? [[String:Any]]
                    for pd in data_detail!{
                        credit = credit + (pd["EQUALISATION_CONTIGENT"] as! Float)
                    }
                    self.array = result!
                     var arrayview = self.control_until.gettotalportfolio(arr: self.array)
                    for i in 0..<arrayview.count{
                        var total = 0 as Float
                        for j in 0..<self.array.count{
                            if(arrayview[i].curent == self.array[j].CURRENCY_ID){
                                total = total + self.array[j].MARKET_VALUE!
                            }
                        }
                        arrayview[i].total = total
                    }
                    
                    self.addview(array: arrayview)
                    

                    self.tableview.reloadData()
                    alertController.dismiss(animated: true, completion: nil);
                }else{
                    self.tableview.reloadData()
                    alertController.dismiss(animated: true, completion: nil);
                }
                
                
                
            }
            
            
        })
        
    }
    func getdatacredit(date: String, investorId: String, alertController : UIAlertController) {
        if(self.arrayView.count > 0){
            for i in 0..<self.arrayView.count{
                let v = self.arrayView[i].viewWithTag(i)
                v?.removeFromSuperview()
                
            }
        }
        connect.getportfolioCredit(investorID: investorId, date : date, completionHandler: {(result) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if((result?.count)!>0){
                    
                    self.array_detail = result!
                    
                    self.tableview.reloadData()
                    alertController.dismiss(animated: true, completion: nil);
                }else{
                    
                    self.tableview.reloadData()
                    alertController.dismiss(animated: true, completion: nil);
                }
                                

                
                
            }
            
            
        })
        
    }
    func addview(array : [Model_total]) {
        arrayView.removeAll()
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        var arrayLable = [UILabel]()
        var arrayLable1 = [UILabel]()
        
        for i in 0..<array.count{
            let a =  UILabel()
            let b = UILabel()
            arrayLable.append(b)
            arrayLable1.append(a)
            let v = UIView()
            v.tag = i
            arrayView.append(v)
            
        }
        
        for i in 0..<array.count{
            
            arrayView[i].backgroundColor = UIColor(red: 242/255, green: 151/255, blue: 55/255, alpha: 1)
            
            arrayView[i].frame = CGRect(x: 0, y: (screenHeight - CGFloat(50*(i + 1))), width: screenWidth, height: CGFloat(50))
            
            
            arrayLable[i].text = "Total"
            arrayLable1[i].text = array[i].curent_display! + " " + formats.formatpricetocurrency(string1:String(format:"%3.2f", array[i].total!))
            arrayLable1[i].textAlignment = .right
            arrayLable[i].frame = CGRect(x: 5, y: (5*(i + 1)) , width: 80, height: 40)
            arrayLable1[i].frame = CGRect(x: 90, y: (5*(i + 1)), width: Int(screenWidth - 100), height: 40)
            
            arrayView[i].addSubview(arrayLable[i])
            arrayView[i].addSubview(arrayLable1[i])
            self.view.addSubview(arrayView[i])
            
            
            
        }
        
    }

}
