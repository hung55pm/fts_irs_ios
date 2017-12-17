//
//  LeftViewController.swift
//  IRSMobile
//
//  Created by Doan Ngoc Hung on 9/26/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

import SlideMenuControllerSwift


class LeftViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,ExpandableHeaderViewDelegate{
    let userdefault = UserDefaults()
    @IBOutlet weak var investor_name: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    var menutransum = ["Transaction Summary"]
    var menus = ["","Investor profile", "Fund Information", "Subcription","Redemption",""]
    var menuinfo = ["Investor Information", "Contact Information", "Bank Account", "Change Password"]
    var menufund = ["Contact Information","Bank Account"]
    var menusub = ["Subscription Order", "Confirmation of Cash Received", "Subscription Note"]
    var menuremd = ["Redemption Order", "Redemption Note", "Confirmation of Cash Paid"]
    var menuorther = ["Portfolio", "Logout"]
    
    var sections = [
        Section(genre: "Transaction Summary",
                movies: [],
                expanded: false),
        Section(genre: "Investor profile",
                movies: ["Investor Information", "Contact Information", "Bank Account", "Change Password"],
                expanded: false),
        Section(genre: "Fund Information",
                movies: ["Contact Information","Bank Account"],
                expanded: false),
        Section(genre: "Subcription",
                movies: ["Subscription Order", "Confirmation of Cash Received", "Subscription Note"],
                expanded: false),
        Section(genre: "Redemption",
                movies: ["Redemption Order", " Redemption Note", "Confirmation of Cash Paid"],
                expanded: false),
        Section(genre: "Portfolio",
                movies: [],
                expanded: false),
        Section(genre: "Logout",
                movies: [],
                expanded: false)
    ]
    
    func changeViewController(section: Int, row: Int) {
        
        switch section {
        case 0:
            //switch row {
           // case 0:
                self.slideMenuController()?.changeMainViewController(AllTransactionViewController(), close: true)
                break
            //default:
            //    break
           // }
        case 1:
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
        case 2:
            switch row {
            case 0:
                self.slideMenuController()?.changeMainViewController(FundContactViewController(), close: true)
                break
            case 1:
                self.slideMenuController()?.changeMainViewController(FunAcountBankViewController(), close: true)
                break
            default:
                break
            }
        case 3:
            switch row {
            case 0:
                self.slideMenuController()?.changeMainViewController(SubOrderViewController(), close: true)
                break
            case 1:
                self.slideMenuController()?.changeMainViewController(SubReciedViewController(), close: true)
                break
            case 2:
                self.slideMenuController()?.changeMainViewController(SubcriptionViewController(), close: true)
                break
            default:
                break
            }
        case 4:
            switch row {
            case 0:
                self.slideMenuController()?.changeMainViewController(RedemOrderViewController(), close: true)
                break
            case 1:
                self.slideMenuController()?.changeMainViewController(RedemptionViewController(), close: true)
                break

            case 2:
                self.slideMenuController()?.changeMainViewController(RedemCashViewController(), close: true)
                break
                
            default:
                break
            }
        case 5:
           // switch row {
           // case 0:
                self.slideMenuController()?.changeMainViewController(PortfolioViewController(), close: true)
                break
            //case 1:
             //   print(1)
                //self.slideMenuController()?.changeMainViewController(LoginViewController(), close: true)
                //                let secondViewController:LoginViewController = LoginViewController()
                //
                //                self.present(secondViewController, animated: true, completion: nil)
                //self.userdefault.set(false, forKey: "IS_CHECK_LOGIN")
                
               // self.dismiss(animated: true, completion: nil)
                //break
           // default:
               // break
        //    }
        case 6:
            self.slideMenuController()?.changeMainViewController(LoginViewController(), close: true)
        //                let secondViewController:LoginViewController = LoginViewController()
        //
        //                self.present(secondViewController, animated: true, completion: nil)
            //self.userdefault.set(false, forKey: "IS_CHECK_LOGIN")
        
            self.dismiss(animated: true, completion: nil)
            break
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
    
   /* func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section==0){
            return menutransum.count
        }else if(section==1){
            return menuinfo.count
        }else if(section==2){
            return menufund.count
        }else if(section==3){
            return menusub.count
        }else if(section==4){
            return menuremd.count
        }else if(section==5){
            return menuorther.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
        if(indexPath.section==0){
            cell.setData(menutransum[indexPath.row])
        }else if(indexPath.section==1){
            cell.setData(menuinfo[indexPath.row])
            
        }else if (indexPath.section==2){
            cell.setData(menufund[indexPath.row])
        }else if (indexPath.section==3){
            cell.setData(menusub[indexPath.row])
        }else if (indexPath.section==4){
            cell.setData(menuremd[indexPath.row])
        }else if (indexPath.section==5){
            cell.setData(menuorther[indexPath.row])
        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.changeViewController(section: indexPath.section, row: indexPath.row)
        let cell = tableView.cellForRow(at: indexPath)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.red
        cell?.selectedBackgroundView = backgroundView
        
    
    
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
    }*/
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded) {
            return 44
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].genre, section: section, delegate: self)
        
        if(section == 0){
        let borderTop = UIView(frame: CGRect(x:0, y:0, width: tableView.bounds.size.width, height: 0.5))
        borderTop.backgroundColor = UIColor.self.init(red: 5/255, green: 16/255, blue: 28/255, alpha: 1.0)
        header.addSubview(borderTop)
        }
        let borderBottom = UIView(frame: CGRect(x:0, y:43, width: tableView.bounds.size.width, height: 0.5))
        borderBottom.backgroundColor = UIColor.self.init(red: 5/255, green: 16/255, blue: 28/255, alpha: 1.0)
        header.addSubview(borderBottom)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
        cell.textLabel?.text = sections[indexPath.section].movies[indexPath.row]
        return cell
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        
        if(section==0 || section==5 || section==6){
           
            self.changeViewController(section: section, row: 0)
            
        }
        tableview.beginUpdates()
        for i in 0 ..< sections[section].movies.count {
           
                tableview.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        
            
        }
        tableview.endUpdates()
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.changeViewController(section: indexPath.section, row: indexPath.row)
        
        
    }
    
    
}
