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
class SubReciedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
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
    var array = [Model_sub_Cash]()
    let connect = ConnectSv()
    let formats = Format()
    let control_until = Control_until()
    var arrayView = [UIView]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.dataSource = self
        self.tableview.delegate = self
        tableview.register(SubReciedTableViewCell.self, forCellReuseIdentifier: "sub")

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
        

        getdata(start: formats.getfirstdayofmounth(), end: formats.getdaynow(), investorId: investor.string(forKey: "INVESTOR_ID")!, alertController: alertController)
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
        self.setNavigationBarItem(title: "Confirmation of Cash Received")
        self.setNavigationBar(title: "Confirmation of Cash Received")
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
        let cells = Bundle.main.loadNibNamed("SubReciedTableViewCell", owner: self, options: nil)?.first as! SubReciedTableViewCell
        if(indexPath.row % 2 == 0){
            cells.backgroundColor = UIColor(colorLiteralRed: 207/255, green: 207/255, blue: 207/255, alpha: 1)
        }
        cells.txt_dealing_date.text = formats.formatdatetoddMMMyyyy(str: array[indexPath.row ].DEALING_DATE!)
        cells.txt_series.text = array[indexPath.row ].SHARE_SERIES_NAME

        cells.txt_date_recived.text = formats.formatdatetoddMMMyyyy(str: array[indexPath.row ].DATE_RECEIVED!)
        
        
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
        return 125.0;
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
        if(self.arrayView.count > 0){
            for i in 0..<self.arrayView.count{
                let v = self.arrayView[i].viewWithTag(i)
                v?.removeFromSuperview()
                
            }
        }
        connect.getsubcriptionRecived(investorID: investorId, stratdate: start, enddate: end, completionHandler: {(result) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if((result?.count)!>0){
                    self.array = result!
                    var arrayview = self.control_until.gettotalsub(arr: self.array)
                    
                    for i in 0..<arrayview.count{
                        var total = 0 as Float
                        for j in 0..<self.array.count{
                            if(arrayview[i].curent == self.array[j].CURRENCY_ID){
                                total = total + self.array[j].AMOUNT!
                            }
                        }
                        arrayview[i].total = total
                    }
                    
                    self.addview(array: arrayview)
                    
                    
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
    func addview(array : [Model_total]) {
        self.arrayView.removeAll()
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
            
           // arrayView[i].backgroundColor = UIColor(red: 242/255, green: 151/255, blue: 55/255, alpha: 1)
            arrayView[i].backgroundColor = .orange
            
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

