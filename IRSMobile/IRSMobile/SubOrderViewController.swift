//
//  SubcriptionViewController.swift




//  IRSMobile
//
//  Created by hungdn on 10/2/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit
import DatePickerDialog
import LSDialogViewController
class SubOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var bt_txt_search: UIButton!
    @IBOutlet weak var tableview: UITableView!
   

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
        getdata(start: start, end: end, investorId: investor.string(forKey: "INVESTOR_ID")!, alertController: alertController)
        
    }
    let investor = UserDefaults()
    var array = [Model_sub_Order]()
    let connect = ConnectSv()
    let formats = Format()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.dataSource = self
        self.tableview.delegate = self
        tableview.register(SubOrderTableViewCell.self, forCellReuseIdentifier: "sub")

        bt_txt_search.layer.cornerRadius = 7
        
        txt_txt.text = formats.getfirstdayofmounth();
        tf_to.text = formats.getdaynow();
        
        let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        
        let spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
        
        print("gsgsgsg",formats.getfirstdayofmounth());

        getdata(start: formats.formatdatetoMMddyyyy(str: txt_txt.text!), end: formats.formatdatetoMMddyyyy(str: tf_to.text!), investorId: investor.string(forKey: "INVESTOR_ID")!, alertController: alertController)
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        txt_txt.resignFirstResponder()
        tf_to.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem(title: "Subscription Order")
        self.setNavigationBar(title: "Subscription Order")
          self.tableview.reloadData()
        
    }

   /* func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.section)
        let dialogViewController: DialogSubViewController = DialogSubViewController(nibName:"DialogSubViewController", bundle: nil)
        dialogViewController.delegate = self
        
        dialogViewController.date = formats.formatdatetoddMMMyyyy(str: array[indexPath.section].DATE!)
        dialogViewController.series = array[indexPath.row ].SHARE_SERIES_NAME
        dialogViewController.tran = array[indexPath.row].TRAN_TYPE_NAME
        dialogViewController.unit = formats.formatpricetocurrency(string1: String(format:"%3." + investor.string(forKey: "QUANTITY_ROUNDING")! + "f", array[indexPath.row ].QUANTITY!))
        dialogViewController.price = formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", array[indexPath.row ].UNIT_PRICE!))
        dialogViewController.amount = formats.formatpricetocurrency(string1:String(format:"%3.2f", array[indexPath.row ].AMOUNT!))
    

        self.presentDialogViewController(dialogViewController, animationPattern: .slideLeftRight, completion: { () -> Void in })
        
    }*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = Bundle.main.loadNibNamed("SubOrderTableViewCell", owner: self, options: nil)?.first as! SubOrderTableViewCell
        if(indexPath.row % 2 == 0){
         
            cells.backgroundColor = Constant.Colors.backgroung_row
        }
        cells.txt_dealing_date.text = formats.formatdatetoddMMMyyyy(str: array[indexPath.row ].DEALING_DATE!)
        cells.txt_series.text = array[indexPath.row ].SHARE_SERIES_NAME

        cells.txt_order_date.text = formats.formatdatetoddMMMyyyy(str: array[indexPath.row ].ORDER_DATE!)
         cells.txt_tran_type.text = array[indexPath.row ].TRAN_TYPE_NAME
        
        if(array[indexPath.row].AMOUNT! < 0 as Float){
            cells.txt_amount.textColor = UIColor.red
            cells.txt_amount.text = "(" + array[indexPath.row].CURRENCY_ID! + " " + formats.formatpricetocurrency(string1:String(format:"%3.2f", array[indexPath.row ].AMOUNT! * -1)) + ")"
        }else{
            cells.txt_amount.text = array[indexPath.row].CURRENCY_ID! + " " + formats.formatpricetocurrency(string1:String(format:"%3.2f", array[indexPath.row ].AMOUNT!))
        }
        
        
        
//        if(indexPath.row == 0){
//            
//            cells.labdate.font = cells.labdate.font.withSize(13)
//            cells.labseries.font = cells.labseries.font.withSize(13)
//            cells.labunit.font = cells.labunit.font.withSize(13)
//            cells.labprice.font = cells.labprice.font.withSize(13)
//            cells.labamount.font = cells.labamount.font.withSize(13)
//            cells.labdate.text = "Date"
//            cells.labseries.text = "Classes/Series"
//            cells.labunit.text = "Unit"
//            cells.labprice.text = "Price"
//            cells.labamount.text = "Amount"
//            cells.backgroundColor = UIColor.blue
//            cells.labdate.textColor = UIColor.white
//            cells.labseries.textColor = UIColor.white
//            cells.labunit.textColor = UIColor.white
//            cells.labprice.textColor = UIColor.white
//            cells.labamount.textColor = UIColor.white
//
//
//            
//        }else if (indexPath.row > 0){
//            cells.labdate.font = cells.labdate.font.withSize(13)
//            cells.labseries.font = cells.labseries.font.withSize(13)
//            cells.labunit.font = cells.labunit.font.withSize(13)
//            cells.labprice.font = cells.labprice.font.withSize(13)
//            cells.labamount.font = cells.labamount.font.withSize(13)
//            cells.labdate.text = formats.formatdatetoddMMMyyyy(str: array[indexPath.row - 1].DATE!)
//            cells.labseries.text = array[indexPath.row - 1].SHARE_SERIES_NAME
//            cells.labunit.text = formats.formatpricetocurrency(string1: String(format:"%3." + investor.string(forKey: "QUANTITY_ROUNDING")! + "f", array[indexPath.row - 1].UNIT_PRICE!))
//            cells.labprice.text = formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", array[indexPath.row - 1].QUANTITY!))
//            cells.labamount.text = formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", array[indexPath.row - 1].AMOUNT!))
//        }
        return cells
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 150.0;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.array.count)
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
    func getdata(start: String, end: String, investorId: String, alertController : UIAlertController) {
        connect.getsubcriptionOrder(investorID: investorId, stratdate: start, enddate: end, completionHandler: {(result) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if((result?.count)!>0){
                    self.array = result!
                    //            self.tableview.reloadData()
                    print("aaaaa" + String(self.array.count))
                    
                    var total_usd : Float = 0
                    var total_sgd :Float = 0
                    if(result?.count != 0){
                        for item in result!{
                            if(item.CURRENCY_ID == "USD"){
                                total_usd = total_usd + item.AMOUNT!
                            }else if(item.CURRENCY_ID == "SGD"){
                                total_sgd = total_sgd + item.AMOUNT!
                            }
                        }
                        print(total_usd)
                    }
                    
                    self.tableview.reloadData()
                    alertController.dismiss(animated: true, completion: nil);
                }else{
                    self.array = result!
                    self.tableview.reloadData()
                    alertController.dismiss(animated: true, completion: nil);
                }
                
                
                
            }
            
            
        })

    }

}

