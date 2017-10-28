//
//  LeftViewController.swift
//  IRSMobile
//
//  Created by Doan Ngoc Hung on 9/26/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

import SlideMenuControllerSwift


class LeftViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    let userdefault = UserDefaults()
    @IBOutlet weak var investor_name: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    
    var menus = ["Investor profile", "Transaction History", ""]
    var menuinfo = ["Investor Information", "Contact Information", "Bank Account", "Change Password"]
    var menutran = ["All Transactions", "Subscription", "Redemption"]
    var menuorther = ["Portfolio", "Logout"]
    func changeViewController(section: Int, row: Int) {
        
        switch section {
        case 0:
            switch row {
            case 0:
                self.slideMenuController()?.changeMainViewController(InvestorInfomationViewController(), close: true)
                break
            case 1:
                self.slideMenuController()?.changeMainViewController(ContactInformationViewController(), close: true)
                break
            case 2:
                self.slideMenuController()?.changeMainViewController(BankAcountViewController(), close: true)
                break
            case 3:
                self.slideMenuController()?.changeMainViewController(ChangePasswordViewController(), close: true)
                break
            default:
                break
            }
        case 1:
            switch row {
            case 0:
                self.slideMenuController()?.changeMainViewController(AllTransactionViewController(), close: true)
                break
            case 1:
                self.slideMenuController()?.changeMainViewController(SubcriptionViewController(), close: true)
                break
            case 2:
                self.slideMenuController()?.changeMainViewController(RedemptionViewController(), close: true)
                break
            default:
                break
            }
        case 2:
            switch row {
            case 0:
                self.slideMenuController()?.changeMainViewController(PortfolioViewController(), close: true)
                break
            case 1:
                print(1)
                let secondViewController:LoginViewController = LoginViewController()
                
                self.present(secondViewController, animated: true, completion: nil)
                self.userdefault.set(false, forKey: "IS_CHECK_LOGIN")
                
                //self.dismiss(animated: false, completion: nil)
                break
            default:
                break
            }
           
            
        default: break
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        tableview.dataSource = self
        tableview.delegate = self
        let investor = UserDefaults()
        
        investor_name.text = investor.string(forKey: "INVESTOR_NAME")
        print("ssssssssssssss" + investor.string(forKey: "INVESTOR_NAME")!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section==0){
            return menuinfo.count
        }else if(section==1){
            return menutran.count
        }else if(section==2){
            return menuorther.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
        if(indexPath.section==0){
            cell.setData(menuinfo[indexPath.row])
        }else if(indexPath.section==1){
            cell.setData(menutran[indexPath.row])
            
        }else if (indexPath.section==2){
            cell.setData(menuorther[indexPath.row])
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.changeViewController(section: indexPath.section, row: indexPath.row)
        var cell = tableView.cellForRow(at: indexPath)!
    
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menus.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menus[section]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableview == scrollView {
            
        }
    }
    
}
