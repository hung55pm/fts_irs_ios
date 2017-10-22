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
        let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: .alert)
        
        let spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
        
        let getshareclass = investor.value(forKey: "SHARE_CLASS") as! [[String:Any]]
        if(chooseDropDown.indexForSelectedRow == 0){
             getdata(shareClassID: getshareclass[chooseDropDown.indexForSelectedRow!]["SHARE_CLASS_ID"] as! String, investorId: investor.string(forKey: "INVESTOR_ID")!, alertController: alertController)
        }else{
             getdata(shareClassID: getshareclass[chooseDropDown.indexForSelectedRow! - 1]["SHARE_CLASS_ID"] as! String, investorId: investor.string(forKey: "INVESTOR_ID")!, alertController: alertController)
        }

        print("index" + String(describing: chooseDropDown.indexForSelectedRow))
    }
    @IBAction func bt_select(_ sender: UIButton) {
        chooseDropDown.show()
    }
    var cells : AllTransactionTableViewCell!
    var array = [Model_AllTransaction]()
    let chooseDropDown = DropDown()
    let investor = UserDefaults()
    let connect = ConnectSv()
    let formats = Format()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(AllTransactionTableViewCell.self, forCellReuseIdentifier: "alltran")
        tableview.dataSource = self
        tableview.delegate = self
        tableview.estimatedRowHeight = 30
        tableview.rowHeight = UITableViewAutomaticDimension
        setupChooseDropDown()
         let myColor = UIColor.orange
        ol_select.layer.borderWidth = 0.5
        ol_select.layer.borderColor = myColor.cgColor
        ol_select.layer.cornerRadius = 7
        

        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar(title: "All Transactions")
        self.setNavigationBarItem(title: "All Transactions")
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cells = tableview.dequeueReusableCell(withIdentifier: "alltran", for: indexPath) as! AllTransactionTableViewCell
        if(indexPath.row == 0){
            
            
            cells.labdate.font = cells.labdate.font.withSize(13)
            cells.labtran.font = cells.labdate.font.withSize(13)
            cells.labseries.font = cells.labseries.font.withSize(13)
            cells.labunit.font = cells.labunit.font.withSize(13)
            cells.labunitbalace.font = cells.labunitbalace.font.withSize(13)
            cells.labamount.font = cells.labamount.font.withSize(13)
            cells.labdate.text = "Date"
            cells.labtran.text = "Transaction"
            cells.labseries.text = "Classes/Series"
            cells.labunit.text = "Unit"
            cells.labunitbalace.text = "Unit Balance"
            cells.labamount.text = "Amount"
            cells.backgroundColor = UIColor.blue
            cells.labdate.textColor = UIColor.white
            cells.labtran.textColor = UIColor.white
            cells.labseries.textColor = UIColor.white
            cells.labunit.textColor = UIColor.white
            cells.labunitbalace.textColor = UIColor.white
            cells.labamount.textColor = UIColor.white
            
            
        }else if (indexPath.row > 0){
            
            cells.labdate.font = cells.labdate.font.withSize(13)
            cells.labtran.font = cells.labdate.font.withSize(13)
            cells.labseries.font = cells.labseries.font.withSize(13)
            cells.labunit.font = cells.labunit.font.withSize(13)
            cells.labunitbalace.font = cells.labunitbalace.font.withSize(13)
            cells.labamount.font = cells.labamount.font.withSize(13)
            
            cells.labdate.text = formats.formatdatetoddMMMyyyy(str: array[indexPath.row - 1].DEALING_DATE!)
            cells.labtran.text = array[indexPath.row - 1].TRAN_TYPE_NAME!
            cells.labseries.text = array[indexPath.row - 1].SHARE_SERIES_NAME
            cells.labunit.text = formats.formatpricetocurrency(string1: String(format:"%3." + investor.string(forKey: "QUANTITY_ROUNDING")! + "f", array[indexPath.row - 1].UNIT_PRICE!))
            cells.labunitbalace.text = formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", array[indexPath.row - 1].QUANTITY!))
            cells.labamount.text = formats.formatpricetocurrency(string1:String(format:"%3." + investor.string(forKey: "PRICE_ROUNDING")! + "f", array[indexPath.row - 1].AMOUNT!))
            
        }

        return cells
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.array.count + 1)
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
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
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
