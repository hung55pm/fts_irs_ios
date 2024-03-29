//
//  ConnectSv.swift
//  IRSMobile
//
//  Created by Doan Ngoc Hung on 9/26/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import Foundation
import Toaster
import SystemConfiguration
class ConnectSv {
    let contant = Constant()
    let userDefaults = UserDefaults.standard
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
    
    func login(user:String, pass: String,completionHandler: @escaping (Int64?) -> ()) -> () {
       let urls = contant.HOST + "/token"
        let urlss = urls.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        var request = URLRequest(url : URL(string: urlss!)!)
        //request.addValue("Bearer " +, forHTTPHeaderField: "Authorization")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")// truyền lên dạng urlencode
        let bodyData = "UserName=" + user + "&Password=" + pass + "&Grant_Type=password"// dữ liệu kiểu form-data
        
        request.httpBody = bodyData.data(using: String.Encoding.utf8);
        request.httpMethod = "POST"// phuong thuc truyen
        
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(error)")
                completionHandler(400)
                return
            }
            
            let responseString = String(data: data!, encoding: .utf8)// get data tra ve dang string
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]
            print("responseString = \(responseString!)")
            if(json?["access_token"] == nil){
                 completionHandler(400)
            }else{
                print(json?["access_token"])
                self.userDefaults.set(json?["access_token"], forKey: "access_token")
                self.userDefaults.set(user, forKey: "USERNAME")
                self.userDefaults.set(pass, forKey: "PASSWORD")
                completionHandler(200)
            }
            
        }
        task.resume()
      
    
    }
    func getopt(completionHandler: @escaping (String) -> ()) {
        let urls = contant.HOST + "/api/OTP/GetOTP"
        var request = URLRequest(url : URL(string: urls)!)
        
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let access_token = userDefaults.value(forKey: "access_token") as! String
        request.addValue("Bearer " + access_token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"// phuong thuc truyen
    
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                completionHandler("fail")
                return
            }
            
            // You can print out response object
            let responseString = String(data: data!, encoding: .utf8)// get data tra ve dang string
            print("responseString = \(responseString)")
           // var result:Int? = Int(responseString!)
            completionHandler(responseString!)
            
        }
        task.resume()
        
        
    }

    
    
    func getinfor(user : String , completionHandler: @escaping (Int64?) -> () ){
        
        let urls = contant.HOST + "/api/Investor/getInfo?UserId=" + user
        let urlss = urls.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        var request = URLRequest(url : URL(string: urlss!)!)
        let access_token = userDefaults.value(forKey: "access_token") as! String
        request.addValue("Bearer " + access_token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"// phuong thuc truyen
        
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                completionHandler(400)
                return
            }
            
            // You can print out response object
            //            print("response = \(String(describing: response))")
            //            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as? [[String:Any]]// get data tar ve dang jsonarray
            
            do {
                let datalogin = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary // get data trar ve khi data tra ve laf mot json object
                
                print(datalogin?.count)
                if((datalogin?.count) != 0){
                let json = datalogin?["INVESTOR"] as! [[String:Any]]
                let DM_ORGANIZATION = datalogin?["DM_ORGANIZATION"] as! [[String:Any]]
                let SHARE_CLASS = datalogin?["SHARE_CLASS"] as! [[String:Any]]
                
                if(DM_ORGANIZATION.count>0){
                    for data_organ in DM_ORGANIZATION{
                        self.userDefaults.set(data_organ["PRICE_ROUNDING"], forKey: "PRICE_ROUNDING")
                        self.userDefaults.set(data_organ["QUANTITY_ROUNDING"], forKey: "QUANTITY_ROUNDING")
                        self.userDefaults.set(data_organ["IS_EQUALISATION"], forKey: "IS_EQUALISATION")
                        self.userDefaults.set(data_organ["DATE_OF_INCORPORATION"], forKey: "DATE_OF_INCORPORATION")
                        
                        self.userDefaults.set(data_organ["ORGANIZATION_ID"], forKey: "ORGANIZATION_ID")
                        self.userDefaults.set(data_organ["ORGANIZATION_NAME"], forKey: "ORGANIZATION_NAME")
                        self.userDefaults.set(data_organ["ADDRESS"], forKey: "ADDRESS")
                        self.userDefaults.set(data_organ["FUND_EMAIL_ENOVESTOR"], forKey: "FUND_EMAIL_ENOVESTOR")
                        self.userDefaults.set(data_organ["FUND_FAX"], forKey: "FUND_FAX")
                        self.userDefaults.set(data_organ["FUND_TEL"], forKey: "FUND_TEL")
                        
                        
                        self.userDefaults.set(data_organ["INTERMEDIATE_BANK"], forKey: "INTERMEDIATE_BANK")
                        self.userDefaults.set(data_organ["BENEFICIARY_BANK"], forKey: "BENEFICIARY_BANK")
                        self.userDefaults.set(data_organ["BENEFICIARY_BANK_BIC"], forKey: "BENEFICIARY_BANK_BIC")
                         self.userDefaults.set(data_organ["BENEFICIARY_ACCOUNT_NUMBER"], forKey: "BENEFICIARY_ACCOUNT_NUMBER")
                         self.userDefaults.set(data_organ["BENEFICIARY_ACCOUNT_NAME"], forKey: "BENEFICIARY_ACCOUNT_NAME")
                        
                        
                    }
                }
                if(SHARE_CLASS.count>0){
                    self.userDefaults.set(SHARE_CLASS, forKey: "SHARE_CLASS")
//                    for data_class in SHARE_CLASS{
//                        userDefaults.set(data_class["SHARE_CLASS_ID"], forKey: "SHARE_CLASS_ID")
//                        userDefaults.set(data_class["SHARE_CLASS_NAME"], forKey: "SHARE_CLASS_NAME")
//                        userDefaults.set(data_class["CURRENCY_ID"], forKey: "CURRENCY_ID")
//                        
//                    }
                }
                if(SHARE_CLASS.count>0){
                    
                }
                
                if( (json.count) == 0){
                    completionHandler(300)
                    
                }else{
                    for dayData in json{// get object trong jsonarray tra ve
                        print(dayData)
                        
                        
                        self.userDefaults.set(dayData["ACCOUNT_NAME"] as? String , forKey : "ACCOUNT_NAME")
                        self.userDefaults.set(dayData["ACCOUNT_NUMBER"] as? String, forKey : "ACCOUNT_NUMBER")
                        self.userDefaults.set(dayData["BANK_ADDRESS"] as? String, forKey : "BANK_ADDRESS")
                        self.userDefaults.set(dayData["BENEFICIARY_BANK"] as? String, forKey : "BENEFICIARY_BANK")
                        self.userDefaults.set(dayData["DATE_OF_BIRTH"] as? String, forKey : "DATE_OF_BIRTH")
                        self.userDefaults.set(dayData["EMAIL"] as? String, forKey : "EMAIL")
                        self.userDefaults.set(dayData["EXPIRY_DATE"] as? String, forKey : "EXPIRY_DATE")
                        self.userDefaults.set(dayData["FACSIMILE"] as? String, forKey : "FACSIMILE")
                        self.userDefaults.set(dayData["GENDER_ID"] as? String, forKey : "GENDER_ID")
                        self.userDefaults.set(dayData["INVESTOR_ID"] as? String, forKey : "INVESTOR_ID")
                        self.userDefaults.set(dayData["INVESTOR_NAME"] as? String, forKey : "INVESTOR_NAME")
                        self.userDefaults.set(dayData["MAILLING_ADDRESS"] as? String, forKey : "MAILLING_ADDRESS")
                        self.userDefaults.set(dayData["NATIONALITY_ID"] as? String, forKey : "NATIONALITY_ID")
                        self.userDefaults.set(dayData["REGISTERED_ADDRESS"] as? String, forKey : "REGISTERED_ADDRESS")
                        self.userDefaults.set(dayData["SWIFT_CODE"] as? String, forKey : "SWIFT_CODE")
                        self.userDefaults.set(dayData["TEL"] as? String, forKey : "TEL")
                        self.userDefaults.set(dayData["PASSPORT_ID"] as? String, forKey : "PASSPORT_ID")
                        
                        
                        
                        
                        
                        
                        completionHandler(200)
                        
                        
                        
                        
                    }
                }
                }else{
                     completionHandler(300)
                }
                
                
            } catch {
                print(error)
            }
            //
            //                        //            let responseString = String(data: data!, encoding: .utf8)// get data tra ve dang string
            //            print("responseString = \(responseString)")
        }
        task.resume()
        
    }
    
    func changpassword(investorId : String,oldpass:String, newpass: String,completionHandler: @escaping (Int) -> ()) {
        let urls = contant.HOST + "/api/Investor/changePassword"
        var request = URLRequest(url : URL(string: urls)!)
        
     
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let access_token = userDefaults.value(forKey: "access_token") as! String
        request.addValue("Bearer " + access_token, forHTTPHeaderField: "Authorization")
        let bodyData = "userID=" + investorId + "&oldPassword=" + oldpass + "&newPassword=" + newpass
        request.httpMethod = "PUT"// phuong thuc truyen
        print("bodydata:  " + bodyData)
        
        request.httpBody = bodyData.data(using: String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                completionHandler(2)
                return
            }
            
            // You can print out response object
                        let responseString = String(data: data!, encoding: .utf8)// get data tra ve dang string
                       print("responseString = \(responseString)")
                        var result:Int? = Int(responseString!)
            completionHandler(result!)

        }
        task.resume()

        
    }

    func updateContact(investorId : String,maillingAddress:String, tel: String,Facsimile:String, email: String,completionHandler: @escaping (Int) -> ()) {
        let urls = contant.HOST + "/api/Investor/UpdateContact"
        var request = URLRequest(url : URL(string: urls)!)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let access_token = userDefaults.value(forKey: "access_token") as! String
        request.addValue("Bearer " + access_token, forHTTPHeaderField: "Authorization")
        let bodyData = "investorId=" + investorId + "&maillingAddress=" + maillingAddress + "&tel=" + tel + "&Facsimile=" + Facsimile + "&email=" + email
        request.httpMethod = "PUT"// phuong thuc truyen
        print("bodydata:  " + bodyData)
        
        request.httpBody = bodyData.data(using: String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                completionHandler(2)
                return
            }
            
            // You can print out response object
            let responseString = String(data: data!, encoding: .utf8)// get data tra ve dang string
            print("responseString = \(responseString)")
            var result:Int? = Int(responseString!)
            completionHandler(result!)
            
        }
        task.resume()
        
        
    }

    
    
    func getsubcription(investorID: String, stratdate: String, enddate: String, completionHandler: @escaping ([Model_Sucription]?) -> () ){
        var array = [Model_Sucription]()
        let urls = contant.HOST + "/api/Transaction/subscriptionNote?investorId=" + investorID + "&startDate=" + stratdate + "&endDate=" + enddate
        let urlss = urls.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        var request = URLRequest(url : URL(string: urlss!)!)
        let access_token = userDefaults.value(forKey: "access_token") as! String
        request.addValue("Bearer " + access_token, forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"// phuong thuc truyen
        
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                completionHandler(array)
                return
            }
            
            // You can print out response object
            print("response = \(String(describing: response))")
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as? [[String:Any]]// get data tar ve dang jsonarray
            
            
            if( (json?.count)! == 0){
                completionHandler(array)
                
            }else{
                for dayData in (json?.reversed())!{// get object trong jsonarray tra ve
                    print(dayData)
                    let model = Model_Sucription()
                    
                    model.DATE = dayData["DATE"] as? String
                    model.SHARE_SERIES_NAME = dayData["SHARE_SERIES_NAME"] as? String
                    model.UNIT_PRICE = dayData["UNIT_PRICE"] as? Float
                    model.QUANTITY = dayData["QUANTITY"] as? Float
                    model.AMOUNT = dayData["AMOUNT"] as? Float
                    model.CURRENCY_ID = dayData["CURRENCY_ID"] as? String
                    model.TRAN_TYPE_NAME = dayData["TRAN_TYPE_NAME"] as? String
                    array.append(model)
                }
                print(array)
                completionHandler(array)
            }
            //            let responseString = String(data: data!, encoding: .utf8)// get data tra ve dang string
            //            print("responseString = \(responseString)")
        }
        task.resume()
        
        
    }

    
    func getsubcriptionRecived(investorID: String, stratdate: String, enddate: String, completionHandler: @escaping ([Model_sub_Cash]?) -> () ){
        var array = [Model_sub_Cash]()
        let urls = contant.HOST + "/api/Transaction/subscriptionCash?investorId=" + investorID + "&startDate=" + stratdate + "&endDate=" + enddate
        let urlss = urls.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        var request = URLRequest(url : URL(string: urlss!)!)
        let access_token = userDefaults.value(forKey: "access_token") as! String
        request.addValue("Bearer " + access_token, forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"// phuong thuc truyen
        
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                completionHandler(array)
                return
            }
            
            // You can print out response object
            print("response = \(String(describing: response))")
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as? [[String:Any]]// get data tar ve dang jsonarray
            
            
            if( (json?.count)! == 0){
                completionHandler(array)
                
            }else{
                for dayData in (json?.reversed())!{// get object trong jsonarray tra ve
                    print(dayData)
                    let model = Model_sub_Cash()
                    
                    model.DATE_RECEIVED = dayData["DATE_RECEIVED"] as? String
                    model.SHARE_SERIES_NAME = dayData["SHARE_SERIES_NAME"] as? String
                    model.DEALING_DATE = dayData["DEALING_DATE"] as? String
                    model.AMOUNT = dayData["AMOUNT"] as? Float
                    model.CURRENCY_ID = dayData["CURRENCY_ID"] as? String
                    array.append(model)
                }
                print(array)
                completionHandler(array)
            }
            //            let responseString = String(data: data!, encoding: .utf8)// get data tra ve dang string
            //            print("responseString = \(responseString)")
        }
        task.resume()
        
        
    }

    func getsubcriptionOrder(investorID: String, stratdate: String, enddate: String, completionHandler: @escaping ([Model_sub_Order]?) -> () ){
        var array = [Model_sub_Order]()
        let urls = contant.HOST + "/api/Transaction/subscriptionOrder?investorId=" + investorID + "&startDate=" + stratdate + "&endDate=" + enddate
        let urlss = urls.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        var request = URLRequest(url : URL(string: urlss!)!)
        let access_token = userDefaults.value(forKey: "access_token") as! String
        request.addValue("Bearer " + access_token, forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"// phuong thuc truyen
        
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                completionHandler(array)
                return
            }
            
            // You can print out response object
            print("response = \(String(describing: response))")
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as? [[String:Any]]// get data tar ve dang jsonarray
            
            
            if( (json?.count)! == 0){
                completionHandler(array)
                
            }else{
                for dayData in (json?.reversed())!{// get object trong jsonarray tra ve
                    print(dayData)
                    let model = Model_sub_Order()
                    
                    model.ORDER_DATE = dayData["ORDER_DATE"] as? String
                    model.SHARE_SERIES_NAME = dayData["SHARE_SERIES_NAME"] as? String
                    model.DEALING_DATE = dayData["DEALING_DATE"] as? String
                    model.AMOUNT = dayData["AMOUNT"] as? Float
                    model.CURRENCY_ID = dayData["CURRENCY_ID"] as? String
                    model.TRAN_TYPE_NAME = dayData["TRAN_TYPE_NAME"] as? String
                    array.append(model)
                }
                print(array)
                completionHandler(array)
            }
            //            let responseString = String(data: data!, encoding: .utf8)// get data tra ve dang string
            //            print("responseString = \(responseString)")
        }
        task.resume()
        
        
    }

    
    
    func getredemption(investorID: String, stratdate: String, enddate: String, completionHandler: @escaping ([Model_Redemption]?) -> () ){
        var array = [Model_Redemption]()
        let urls = contant.HOST + "/api/Transaction/redemptionNote?investorId=" + investorID + "&startDate=" + stratdate + "&endDate=" + enddate
        let urlss = urls.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        var request = URLRequest(url : URL(string: urlss!)!)
        let access_token = userDefaults.value(forKey: "access_token") as! String
        request.addValue("Bearer " + access_token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"// phuong thuc truyen
        
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                completionHandler(array)
                return
            }
            
            // You can print out response object
            print("response = \(String(describing: response))")
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as? [[String:Any]]// get data tar ve dang jsonarray
            
            
            if( (json?.count)! == 0){
                completionHandler(array)
                
            }else{
                for dayData in (json?.reversed())!{// get object trong jsonarray tra ve
                    print(dayData)
                    let model = Model_Redemption()
                    
                    model.DATE = dayData["DATE"] as? String
                    model.SHARE_SERIES_NAME = dayData["SHARE_SERIES_NAME"] as? String
                    model.UNIT_PRICE = dayData["UNIT_PRICE"] as? Float
                    model.QUANTITY = dayData["QUANTITY"] as? Float
                    model.AMOUNT = dayData["AMOUNT"] as? Float
                    model.CURRENCY_ID = dayData["CURRENCY_ID"] as? String
                    model.TRAN_TYPE_NAME = dayData["TRAN_TYPE_NAME"] as? String
                    array.append(model)
                }
                print(array)
                completionHandler(array)
            }
            //            let responseString = String(data: data!, encoding: .utf8)// get data tra ve dang string
            //            print("responseString = \(responseString)")
        }
        task.resume()
        
        
    }
   
    func getredemptionCash(investorID: String, stratdate: String, enddate: String, completionHandler: @escaping ([Model_rem_Cash]?) -> () ){
        var array = [Model_rem_Cash]()
        let urls = contant.HOST + "/api/Transaction/redemptionCash?investorId=" + investorID + "&startDate=" + stratdate + "&endDate=" + enddate
        let urlss = urls.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        var request = URLRequest(url : URL(string: urlss!)!)
        let access_token = userDefaults.value(forKey: "access_token") as! String
        request.addValue("Bearer " + access_token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"// phuong thuc truyen
        
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                completionHandler(array)
                return
            }
            
            // You can print out response object
            print("response = \(String(describing: response))")
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as? [[String:Any]]// get data tar ve dang jsonarray
            
            
            if( (json?.count)! == 0){
                completionHandler(array)
                
            }else{
                for dayData in (json?.reversed())!{// get object trong jsonarray tra ve
                    print(dayData)
                    let model = Model_rem_Cash()
                    
                    model.DATE_PAID = dayData["DATE_PAID"] as? String
                    model.SHARE_SERIES_NAME = dayData["SHARE_SERIES_NAME"] as? String
                    model.AMOUNT = dayData["AMOUNT"] as? Float
                    model.CURRENCY_ID = dayData["CURRENCY_ID"] as? String
                    model.DEALING_DATE = dayData["DEALING_DATE"] as? String
                    array.append(model)
                }
                print(array)
                completionHandler(array)
            }
            //            let responseString = String(data: data!, encoding: .utf8)// get data tra ve dang string
            //            print("responseString = \(responseString)")
        }
        task.resume()
        
        
    }
    
    func getredemptionOrder(investorID: String, stratdate: String, enddate: String, completionHandler: @escaping ([Model_rem_Order]?) -> () ){
        var array = [Model_rem_Order]()
        let urls = contant.HOST + "/api/Transaction/redemptionOrder?investorId=" + investorID + "&startDate=" + stratdate + "&endDate=" + enddate
        let urlss = urls.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        var request = URLRequest(url : URL(string: urlss!)!)
        let access_token = userDefaults.value(forKey: "access_token") as! String
        request.addValue("Bearer " + access_token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"// phuong thuc truyen
        
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                completionHandler(array)
                return
            }
            
            // You can print out response object
            print("response = \(String(describing: response))")
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as? [[String:Any]]// get data tar ve dang jsonarray
            
            
            if( (json?.count)! == 0){
                completionHandler(array)
                
            }else{
                for dayData in (json?.reversed())!{// get object trong jsonarray tra ve
                    print(dayData)
                    let model = Model_rem_Order()
                    
                    model.ORDER_DATE = dayData["ORDER_DATE"] as? String
                    model.SHARE_SERIES_NAME = dayData["SHARE_SERIES_NAME"] as? String
                    model.DEALING_DATE = dayData["DEALING_DATE"] as? String
                    model.AMOUNT = dayData["AMOUNT"] as? Float
                    model.CURRENCY_ID = dayData["CURRENCY_ID"] as? String
                    model.TRAN_TYPE_NAME = dayData["TRAN_TYPE_NAME"] as? String
                    array.append(model)
                }
                print(array)
                completionHandler(array)
            }
            //            let responseString = String(data: data!, encoding: .utf8)// get data tra ve dang string
            //            print("responseString = \(responseString)")
        }
        task.resume()
        
        
    }
    
    
    func getalltransaction(investorID: String, shareClassID: String , completionHandler: @escaping ([Model_AllTransaction]?) -> () ){
        var array = [Model_AllTransaction]()
        let urls = contant.HOST + "/api/Transaction/AllTransaction?investorId=" + investorID + "&shareClassID=" + shareClassID
        print("url" + urls);
        let urlss = urls.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        
        var request = URLRequest(url : URL(string: urlss!)!)
        let access_token = userDefaults.value(forKey: "access_token") as! String
        request.addValue("Bearer " + access_token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"// phuong thuc truyen
        
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                completionHandler(array)
                return
            }
            do {
                let datatran = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary // get data trar ve khi data tra ve laf mot json object
                print(datatran)
                let json = datatran?["SHAREHOLDER_MOVEMENT"] as! [[String:Any]]
                if((datatran?.count)!>0){
                    self.userDefaults.set(datatran?["CONVERSION_SHARES"], forKey: "CONVERSION_SHARES")
                }
                if(json.count>0){
                    for daydata in json.reversed(){
                        let model = Model_AllTransaction()
                        model.PR_KEY = daydata["PR_KEY"] as? Float
                        model.DEALING_DATE = daydata["DEALING_DATE"] as? String
                         model.TRAN_TYPE_NAME = daydata["TRAN_TYPE_NAME"] as? String
                        model.TRAN_TYPE_ID = daydata["TRAN_TYPE_ID"] as? String
                        model.SHARE_SERIES_NAME = daydata["SHARE_SERIES_NAME"] as? String
                        model.UNIT_PRICE = daydata["UNIT_PRICE"] as? Float
                        model.QUANTITY = daydata["QUANTITY"] as? Float
                        model.AMOUNT = daydata["AMOUNT"] as? Float
                        model.QUANTITY_BALANCE = daydata["QUANTITY_BALANCE"] as? String
                        print("Quantity" + String(describing: model.QUANTITY_BALANCE))
                        model.CURRENCY_ID = daydata["CURRENCY_ID"] as? String
                        array.append(model)

                    }
                    
                    
                    completionHandler(array)
                }else{
                    completionHandler(array)
                }
                
            }catch{
                completionHandler(array)
            print(error)
            }

            
           
        }
        task.resume()
        
        
    }

    func getportfolio(investorID: String, date: String , completionHandler: @escaping ([Model_Portfolio]?) -> () ){
        var array = [Model_Portfolio]()
        let urls = contant.HOST + "/api/Transaction/Portfolio?investorId=" + investorID + "&date=" + date
        print("url" + urls);
        let urlss = urls.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        var request = URLRequest(url : URL(string: urlss!)!)
        let access_token = userDefaults.value(forKey: "access_token") as! String
        request.addValue("Bearer " + access_token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"// phuong thuc truyen
        
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                completionHandler(array)
                return
            }
            do {
                let dataport = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary // get data trar ve khi data tra ve laf mot json object
                
                let json = dataport?["BALANCE"] as! [[String:Any]]
                let MOVEMENT = dataport?["MOVEMENT"] as! [[String: Any]]
                 self.userDefaults.set(MOVEMENT, forKey: "MOVEMENT")
                if(json.count>0){
                    for daydata in json.reversed(){
                        let model = Model_Portfolio()
                        
                
                        model.SERIES_CLASS = daydata["SERIES_CLASS"] as? String
                        model.UNIT_PRICE = daydata["UNIT_PRICE"] as? Float
                        model.QUANTITY = daydata["QUANTITY"] as? Float
                        model.MARKET_VALUE = daydata["MARKET_VALUE"] as? Float
                        model.CURRENCY_ID = daydata["CURRENCY_ID"] as? String
                        array.append(model)
                        
                    }
                    
                   
                
                    
                    
                    completionHandler(array)
                }else{
                    completionHandler(array)
                }
                
            }catch{
                completionHandler(array)
                print(error)
            }
            
            
            
        }
        task.resume()
        
        
    }
    func getportfolioCredit(investorID: String, date: String , completionHandler: @escaping ([Model_Portfolio_detail]?) -> () ){
        var array = [Model_Portfolio_detail]()
        let urls = contant.HOST + "/api/Transaction/Portfolio?investorId=" + investorID + "&date=" + date
        print("url" + urls);
        let urlss = urls.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        var request = URLRequest(url : URL(string: urlss!)!)
        let access_token = userDefaults.value(forKey: "access_token") as! String
        request.addValue("Bearer " + access_token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"// phuong thuc truyen
        
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                completionHandler(array)
                return
            }
            do {
                let dataport = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary // get data trar ve khi data tra ve laf mot json object
                
                let json = dataport?["BALANCE"] as! [[String:Any]]
                let MOVEMENT = dataport?["MOVEMENT"] as! [[String: Any]]
                self.userDefaults.set(MOVEMENT, forKey: "MOVEMENT")
                if(json.count>0){
                    for daydata in MOVEMENT.reversed(){
                        let model = Model_Portfolio_detail()
                        
                        
                        model.DEALING_DATE = daydata["DEALING_DATE"] as? String
                        model.TRAN_TYPE_NAME = daydata["TRAN_TYPE_NAME"] as? String
                        model.QUANTITY = daydata["QUANTITY"] as? Float
                        model.MARKET_VALUE = daydata["MARKET_VALUE"] as? Float
                        model.CURRENCY_ID = daydata["CURRENCY_ID"] as? String
                        model.EQUALISATION_CONTIGENT = daydata["EQUALISATION_CONTIGENT"]as? Float
                        array.append(model)
                        
                    }
                    
                    
                    
                    
                    
                    completionHandler(array)
                }else{
                    completionHandler(array)
                }
                
            }catch{
                completionHandler(array)
                print(error)
            }
            
            
            
        }
        task.resume()
        
        
    }
    
}
