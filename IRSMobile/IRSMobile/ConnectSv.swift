//
//  ConnectSv.swift
//  IRSMobile
//
//  Created by Doan Ngoc Hung on 9/26/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import Foundation
import Toaster
class ConnectSv {
    let contant = Constant()
       let userDefaults = UserDefaults.standard
    func login(user : String , pass : String, completionHandler: @escaping (Int64?) -> () ){
     
        let urls = contant.HOST + "/api/Login/checkLogin?investorId=" + user + "&password=" + pass
        
        var request = URLRequest(url : URL(string: urls)!)
        
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
                let json = datalogin?["INVESTOR"] as! [[String:Any]]
                let DM_ORGANIZATION = datalogin?["DM_ORGANIZATION"] as! [[String:Any]]
                let SHARE_CLASS = datalogin?["SHARE_CLASS"] as! [[String:Any]]
                
                if(DM_ORGANIZATION.count>0){
                    for data_organ in DM_ORGANIZATION{
                        self.userDefaults.set(data_organ["PRICE_ROUNDING"], forKey: "PRICE_ROUNDING")
                        self.userDefaults.set(data_organ["QUANTITY_ROUNDING"], forKey: "QUANTITY_ROUNDING")
                        
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
                
                
            } catch {
                print(error)
            }
            //
            //                        //            let responseString = String(data: data!, encoding: .utf8)// get data tra ve dang string
            //            print("responseString = \(responseString)")
        }
        task.resume()
        
    }
    
    func getsubcription(investorID: String, stratdate: String, enddate: String, completionHandler: @escaping ([Model_Sucription]?) -> () ){
        var array = [Model_Sucription]()
        let urls = contant.HOST + "/api/Transaction/subscription?investorId=" + investorID + "&startDate=" + stratdate + "&endDate=" + enddate
        
        var request = URLRequest(url : URL(string: urls)!)
        
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
                for dayData in json!{// get object trong jsonarray tra ve
                    print(dayData)
                    let model = Model_Sucription()
                    
                    model.DATE = dayData["DATE"] as? String
                    model.SHARE_SERIES_NAME = dayData["SHARE_SERIES_NAME"] as? String
                    model.UNIT_PRICE = dayData["UNIT_PRICE"] as? Float
                    model.QUANTITY = dayData["QUANTITY"] as? Float
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
    func getredemption(investorID: String, stratdate: String, enddate: String, completionHandler: @escaping ([Model_Redemption]?) -> () ){
        var array = [Model_Redemption]()
        let urls = contant.HOST + "/api/Transaction/redemption?investorId=" + investorID + "&startDate=" + stratdate + "&endDate=" + enddate
        
        var request = URLRequest(url : URL(string: urls)!)
        
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
                for dayData in json!{// get object trong jsonarray tra ve
                    print(dayData)
                    let model = Model_Redemption()
                    
                    model.DATE = dayData["DATE"] as? String
                    model.SHARE_SERIES_NAME = dayData["SHARE_SERIES_NAME"] as? String
                    model.UNIT_PRICE = dayData["UNIT_PRICE"] as? Float
                    model.QUANTITY = dayData["QUANTITY"] as? Float
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
    func getalltransaction(investorID: String, shareClassID: String , completionHandler: @escaping ([Model_AllTransaction]?) -> () ){
        var array = [Model_AllTransaction]()
        let urls = contant.HOST + "/api/Transaction/AllTransaction?investorId=" + investorID + "&shareClassID=" + shareClassID
        print("url" + urls);
        
        var request = URLRequest(url : URL(string: urls)!)
        
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
                
                let json = datatran?["SHAREHOLDER_MOVEMENT"] as! [[String:Any]]
                if(json.count>0){
                    for daydata in json{
                        let model = Model_AllTransaction()
                        
                        model.DEALING_DATE = daydata["DEALING_DATE"] as? String
                         model.TRAN_TYPE_NAME = daydata["TRAN_TYPE_NAME"] as? String
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
        
        var request = URLRequest(url : URL(string: urls)!)
        
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
                    for daydata in json{
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

    
}
