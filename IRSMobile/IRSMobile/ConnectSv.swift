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
    
    func login(user : String , pass : String, completionHandler: @escaping (Int64?) -> () ){
        let invetor = Model_Invertor()
        let userDefaults = UserDefaults.standard
        let urls = "http://117.0.38.37:8259/api/Login/checkLogin?investorId=" + user + "&password=" + pass
        
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
            print("response = \(String(describing: response))")
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as? [[String:Any]]// get data tar ve dang jsonarray
            
            
            if( (json?.count)! == 0){
                completionHandler(300)
                
            }else{
                for dayData in json!{// get object trong jsonarray tra ve
                    print(dayData)
                    
                    //                invetor.ACCOUNT_NAME = dayData["ACCOUNT_NAME"] as? String
                    //                invetor.ACCOUNT_NUMBER = dayData["ACCOUNT_NUMBER"] as? String
                    //                invetor.BANK_ADDRESS = dayData["BANK_ADDRESS"] as? String
                    //                invetor.BENEFICIARY_BANK = dayData["BENEFICIARY_BANK"] as? String
                    //                invetor.DATE_OF_BIRTH = dayData["DATE_OF_BIRTH"] as? String
                    //                invetor.EMAIL = dayData["EMAIL"] as? String
                    //                invetor.EXPIRY_DATE = dayData["EXPIRY_DATE"] as? String
                    //                invetor.FACSIMILE = dayData["FACSIMILE"] as? String
                    //                invetor.GENDER_ID = dayData["GENDER_ID"] as? String
                    //                invetor.INVESTOR_ID = dayData["INVESTOR_ID"] as? String
                    //                invetor.INVESTOR_NAME = dayData["INVESTOR_NAME"] as? String
                    //                invetor.MAILLING_ADDRESS = dayData["MAILLING_ADDRESS"] as? String
                    //                invetor.NATIONALITY_ID = dayData["NATIONALITY_ID"] as? String
                    //                invetor.REGISTERED_ADDRESS = dayData["REGISTERED_ADDRESS"] as? String
                    //                invetor.SWIFT_CODE = dayData["SWIFT_CODE"] as? String
                    //                invetor.TEL = dayData["TEL"] as? String
                    
                    
                    userDefaults.set(dayData["ACCOUNT_NAME"] as? String , forKey : "ACCOUNT_NAME")
                    userDefaults.set(dayData["ACCOUNT_NUMBER"] as? String, forKey : "ACCOUNT_NUMBER")
                    userDefaults.set(dayData["BANK_ADDRESS"] as? String, forKey : "BANK_ADDRESS")
                    userDefaults.set(dayData["BENEFICIARY_BANK"] as? String, forKey : "BENEFICIARY_BANK")
                    userDefaults.set(dayData["DATE_OF_BIRTH"] as? String, forKey : "DATE_OF_BIRTH")
                    userDefaults.set(dayData["EMAIL"] as? String, forKey : "EMAIL")
                    userDefaults.set(dayData["EXPIRY_DATE"] as? String, forKey : "EXPIRY_DATE")
                    userDefaults.set(dayData["FACSIMILE"] as? String, forKey : "FACSIMILE")
                    userDefaults.set(dayData["GENDER_ID"] as? String, forKey : "GENDER_ID")
                    userDefaults.set(dayData["INVESTOR_ID"] as? String, forKey : "INVESTOR_ID")
                    userDefaults.set(dayData["INVESTOR_NAME"] as? String, forKey : "INVESTOR_NAME")
                    userDefaults.set(dayData["MAILLING_ADDRESS"] as? String, forKey : "MAILLING_ADDRESS")
                    userDefaults.set(dayData["NATIONALITY_ID"] as? String, forKey : "NATIONALITY_ID")
                    userDefaults.set(dayData["REGISTERED_ADDRESS"] as? String, forKey : "REGISTERED_ADDRESS")
                    userDefaults.set(dayData["SWIFT_CODE"] as? String, forKey : "SWIFT_CODE")
                    userDefaults.set(dayData["TEL"] as? String, forKey : "TEL")
                    
                    
                    
                   
                    completionHandler(200)
                    
                    
                    
                    
                }
            }
            //            let responseString = String(data: data!, encoding: .utf8)// get data tra ve dang string
            //            print("responseString = \(responseString)")
        }
        task.resume()
        
    }
    
}
