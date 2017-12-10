//
//  AllTransactionViewController.swift
//  IRSMobile
//
//  Created by Doan Ngoc Hung on 9/26/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import DropDown
import DatePickerDialog
class AllTransactionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var ol_from: UITextField!
    @IBAction func bt_from(_ sender: UITextField) {
    }
    
    @IBOutlet weak var ol_to: UITextField!
    @IBAction func bt_to(_ sender: UITextField) {
    }
    
    
    @IBOutlet weak var ol_search: UIButton!
    @IBOutlet weak var ol_select: UIButton!
    
    @IBOutlet weak var tableview: UITableView!
    @IBAction func bt_search(_ sender: UIButton) {
        
        let getshareclass = investor.value(forKey: "SHARE_CLASS") as! [[String:Any]]
        if(chooseDropDown.indexForSelectedRow == 0){
            loaddata(shareclass: getshareclass[chooseDropDown.indexForSelectedRow!]["SHARE_CLASS_ID"] as! String)
        }else{
            
            loaddata(shareclass: getshareclass[chooseDropDown.indexForSelectedRow! - 1 ]["SHARE_CLASS_ID"] as! String)
        }

        print("index" + String(describing: chooseDropDown.indexForSelectedRow))
    }
    @IBAction func bt_select(_ sender: UIButton) {
        chooseDropDown.show()
    }
    var array = [Model_AllTransaction]()
    let chooseDropDown = DropDown()
    let investor = UserDefaults()
    let connect = ConnectSv()
    let formats = Format()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableViewAutomaticDimension
        setupChooseDropDown()
         let myColor = UIColor.orange
        ol_select.layer.borderWidth = 0.5
        ol_select.layer.borderColor = myColor.cgColor
        ol_select.layer.cornerRadius = 7
  
        let getshareclass = investor.value(forKey: "SHARE_CLASS") as! [[String:Any]]
       loaddata(shareclass: getshareclass[chooseDropDown.indexForSelectedRow!]["SHARE_CLASS_ID"] as! String)
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar(title: "Transactions Summary")
        self.setNavigationBarItem(title: "Transactions Summary")
        
        
    }
    func loaddata(shareclass : String){
        let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        
        let spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
        getdata(shareClassID: shareclass, investorId: investor.string(forKey: "INVESTOR_ID")!, alertController: alertController)
    }
    
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(array[indexPath.row].TRAN_TYPE_ID == "CON"){
            let dialogViewController: DialogConvesionShareViewController = DialogConvesionShareViewController(nibName:"DialogConvesionShareViewController", bundle: nil)
            dialogViewController.delegate = self
            let getconvesion = investor.value(forKey: "CONVERSION_SHARES") as! [[String:Any]]
            for item in getconvesion{
                var pkey : Float = item["PR_KEY"] as! Float
                if(pkey == array[indexPath.row].PR_KEY){
                    dialogViewController.date = formats.formatdatetoddMMMyyyy(str: item["DEALING_DATE"] as! String)
                    dialogViewController.tran = array[indexPath.row].TRAN_TYPE_NAME!
                    dialogViewController.point = formats.formatdatetoddMMMyyyy(str: array[indexPath.row].DEALING_DATE!)
                    dialogViewController.from = item["FROM_SHARE_SERIES_NAME"] as! String
                    dialogViewController.from_unit = formats.formatpricetocurrency(string1: String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", item["FROM_UNIT_PRICE"] as! Float))
                    dialogViewController.from_price = formats.formatpricetocurrency(string1: String(format:"%3." + investor.string(forKey: "QUANTITY_ROUNDING")! + "f", item["FROM_QUANTITY"] as! Float))
                    dialogViewController.from_amount = formats.formatpricetocurrency(string1: String(format:"%3.2f", item["FROM_AMOUNT"] as! Float))
                    dialogViewController.to =  item["TO_SHARE_SERIES_NAME"] as! String
                        
                    dialogViewController.to_unit = formats.formatpricetocurrency(string1: String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", item["TO_UNIT_PRICE"] as! Float))
                    dialogViewController.to_price = formats.formatpricetocurrency(string1: String(format:"%3." + investor.string(forKey: "QUANTITY_ROUNDING")! + "f", item["TO_QUANTITY"] as! Float))
                    dialogViewController.to_amount = formats.formatpricetocurrency(string1: String(format:"%3.2f", item["TO_AMOUNT"] as! Float))
                    
                     self.presentDialogViewController(dialogViewController, animationPattern: .slideLeftRight, completion: { () -> Void in })
                    
                }
                
            }
            


            
           
            
        }else{
        let dialogViewController: DialogAllTranViewController = DialogAllTranViewController(nibName:"DialogAllTranViewController", bundle: nil)
        dialogViewController.delegate = self
        
        dialogViewController.date = formats.formatdatetoddMMMyyyy(str: array[indexPath.row].DEALING_DATE!)
        
        dialogViewController.tran = array[indexPath.row].TRAN_TYPE_NAME
        
        
        dialogViewController.series = array[indexPath.row ].SHARE_SERIES_NAME
        
        
        dialogViewController.unit = formats.formatpricetocurrency(string1: String(format:"%3." + investor.string(forKey: "QUANTITY_ROUNDING")! + "f", array[indexPath.row ].UNIT_PRICE!))
        
        
        dialogViewController.unit_balance = formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", Float(array[indexPath.row ].QUANTITY_BALANCE!)!))
        
        
        dialogViewController.amount = array[indexPath.row].CURRENCY_ID! + " " + formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", array[indexPath.row ].AMOUNT!))
        
          dialogViewController.qty = formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "QUANTITY_ROUNDING")! + "f", array[indexPath.row ].QUANTITY!))
        
        
        print(" qty " + array[indexPath.row ].QUANTITY_BALANCE!)
        self.presentDialogViewController(dialogViewController, animationPattern: .slideLeftRight, completion: { () -> Void in })
        }

    }*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cells = Bundle.main.loadNibNamed("AllTranTableViewCell", owner: self, options: nil)?.first as! AllTranTableViewCell
        
        if(indexPath.row % 2 == 0){
            cells.backgroundColor = UIColor(colorLiteralRed: 207/255, green: 207/255, blue: 207/255, alpha: 1)
        }
        cells.txt_date.text = formats.formatdatetoddMMMyyyy(str: array[indexPath.row ].DEALING_DATE!)
        cells.txt_trantype.text = array[indexPath.row].TRAN_TYPE_NAME!
        cells.txt_series.text = array[indexPath.row].SHARE_SERIES_NAME!
        
        if(array[indexPath.row].AMOUNT! < 0 as Float){
             cells.txt_amount.textColor = UIColor.red
            cells.txt_amount.text = "(" + array[indexPath.row].CURRENCY_ID! + " " + formats.formatpricetocurrency(string1:String(format:"%3.2f", array[indexPath.row].AMOUNT! * -1)) + ")"
        }else{
             cells.txt_amount.text = array[indexPath.row].CURRENCY_ID! + " " + formats.formatpricetocurrency(string1:String(format:"%3.2f", array[indexPath.row].AMOUNT!))
            
        }
        
        if(array[indexPath.row].QUANTITY! < 0 as Float){
            cells.txt_unit.textColor = UIColor.red
            cells.txt_unit.text = "(" + formats.formatpricetocurrency(string1: String(format:"%3." + investor.string(forKey: "QUANTITY_ROUNDING")! + "f", array[indexPath.row].QUANTITY! * -1)) + ")"
        }else{
            cells.txt_unit.text = formats.formatpricetocurrency(string1: String(format:"%3." + investor.string(forKey: "QUANTITY_ROUNDING")! + "f", array[indexPath.row].QUANTITY!))
        }
    
        if(array[indexPath.row].UNIT_PRICE! < 0 as Float){
            cells.txt_price.textColor = UIColor.red
            cells.txt_price.text = "(" + formats.formatpricetocurrency(string1: String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", array[indexPath.row].UNIT_PRICE! * -1)) + ")"
        }else{
            cells.txt_price.text = formats.formatpricetocurrency(string1: String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", array[indexPath.row].UNIT_PRICE!))
        }
            cells.txt_unit_balance.text = formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "QUANTITY_ROUNDING")! + "f", Float(array[indexPath.row].QUANTITY_BALANCE!)!))
        
        print("hhhhhh " + array[indexPath.row].QUANTITY_BALANCE!);
       
        
        
           // cells.txt_price.text =
        
        
//        if(indexPath.row == 0){
//            
//            
//            cells.labdate.font = cells.labdate.font.withSize(13)
//            cells.labtran.font = cells.labdate.font.withSize(13)
//            cells.labseries.font = cells.labseries.font.withSize(13)
//            cells.labunit.font = cells.labunit.font.withSize(13)
//            cells.labunitbalace.font = cells.labunitbalace.font.withSize(13)
//            cells.labamount.font = cells.labamount.font.withSize(13)
//            cells.labdate.text = "Date"
//            cells.labtran.text = "Transaction"
//            cells.labseries.text = "Classes/Series"
//            cells.labunit.text = "Unit"
//            cells.labunitbalace.text = "Unit Balance"
//            cells.labamount.text = "Amount"
//            cells.backgroundColor = UIColor.blue
//            cells.labdate.textColor = UIColor.white
//            cells.labtran.textColor = UIColor.white
//            cells.labseries.textColor = UIColor.white
//            cells.labunit.textColor = UIColor.white
//            cells.labunitbalace.textColor = UIColor.white
//            cells.labamount.textColor = UIColor.white
//            
//            
//        }else if (indexPath.row > 0){
//            
//            cells.labdate.font = cells.labdate.font.withSize(13)
//            cells.labtran.font = cells.labdate.font.withSize(13)
//            cells.labseries.font = cells.labseries.font.withSize(13)
//            cells.labunit.font = cells.labunit.font.withSize(13)
//            cells.labunitbalace.font = cells.labunitbalace.font.withSize(13)
//            cells.labamount.font = cells.labamount.font.withSize(13)
//            
//            cells.labdate.text = formats.formatdatetoddMMMyyyy(str: array[indexPath.row - 1].DEALING_DATE!)
//            cells.labtran.text = array[indexPath.row - 1].TRAN_TYPE_NAME!
//            cells.labseries.text = array[indexPath.row - 1].SHARE_SERIES_NAME
//            cells.labunit.text = formats.formatpricetocurrency(string1: String(format:"%3." + investor.string(forKey: "QUANTITY_ROUNDING")! + "f", array[indexPath.row - 1].UNIT_PRICE!))
//            cells.labunitbalace.text = formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", array[indexPath.row - 1].QUANTITY!))
//            cells.labamount.text = formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", array[indexPath.row - 1].AMOUNT!))
//            
//        }
    
        return cells
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 210.0;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.array.count)
    }
    
    func setupChooseDropDown() {
        chooseDropDown.anchorView = ol_select
        let getshareclass = investor.value(forKey: "SHARE_CLASS") as! [[String:Any]]
        var arr : [String] = []
        arr.append("All")
        if((getshareclass.count)>0){
            for data_class in getshareclass{
                arr.append(data_class["SHARE_CLASS_NAME"] as! String)
            }
            
        }
        // By default, the dropdown will have its origin on the top left corner of its anchor view
        // So it will come over the anchor view and hide it completely
        // If you want to have the dropdown underneath your anchor view, you can do this:
        chooseDropDown.bottomOffset = CGPoint(x: 0, y: ol_select.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        chooseDropDown.dataSource = arr
         chooseDropDown.selectRow(at: 0)
        self.ol_select.setTitle(arr[0], for: .normal)
        // Action triggered on selection
        chooseDropDown.selectionAction = { [unowned self] (index, item) in
            self.ol_select.setTitle(item, for: .normal)
        }
        chooseDropDown.width = 140
       
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
    func getdata(shareClassID: String, investorId: String, alertController : UIAlertController) {
        connect.getalltransaction(investorID: investorId, shareClassID : shareClassID, completionHandler: {(result) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if((result?.count)!>0){
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
