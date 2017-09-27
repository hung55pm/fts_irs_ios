//
//  LeftViewController.swift
//  IRSMobile
//
//  Created by Doan Ngoc Hung on 9/26/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import UIKit

import SlideMenuControllerSwift
enum LeftMenu: Int {
    case main = 0
    case swift
    case java
    case go
    case nonMenu
}
protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}
class LeftViewController: UIViewController , LeftMenuProtocol{
    
  
    @IBOutlet weak var tableview: UITableView!
    var menus = ["Main", "Swift", "Java", "Go", "NonMenu"]
    func changeViewController(_ menu: LeftMenu) {
        print(menu)
        switch menu {
        case .main:
            self.slideMenuController()?.changeMainViewController(MainViewController(), close: true)
            break
        case .swift: break
        //self.slideMenuController()?.changeMainViewController(self.swiftViewController, close: true)
        case .java:
            self.slideMenuController()?.changeMainViewController(AllTransactionViewController(), close: true)
        case .go: break
        // self.slideMenuController()?.changeMainViewController(self.goViewController, close: true)
        case .nonMenu: break
            // self.slideMenuController()?.changeMainViewController(self.nonMenuViewController, close: true)
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
 //       self.slideMenuController()
        // Do any additional setup after loading the view.
    }
    
}
extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .main, .swift, .java, .go, .nonMenu:
                return BaseTableViewCell.height()
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row ) {
            print("row" + String(indexPath.row))
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableview == scrollView {
            
        }
    }
}

extension LeftViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .main, .swift, .java, .go, .nonMenu:
                //let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
                let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
                cell.setData(menus[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}
