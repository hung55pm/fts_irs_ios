//
//  Format.swift
//  IRSMobile
//
//  Created by hungdn on 10/4/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import Foundation
class Format{
    func formatdatetoddMMMyyyy(str: String) -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: str)!
        
        dateFormatter.dateFormat = "dd-MMM-yy"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    func formatdatefromyyyyMMdd(str: String) -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let date = dateFormatter.date(from: str)!
        
        dateFormatter.dateFormat = "dd-MMM-yy"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    func formatdatetoMMddyyyy(str: String) -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let date = dateFormatter.date(from: str)!
        
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    
    func formatpricetocurrency(string1 : String) -> String {
        var token = string1.components(separatedBy: ".")
        var str : String = ""
        for it in token{
            print("item  " + it)
        }
        var arrstr : [String] = []
        arrstr.append(token[1])
        var substring2 = token[0]
        if(substring2.characters.count>3){
            while substring2.characters.count>3 {
                let index2 = substring2.index(substring2.endIndex, offsetBy: -3)
                var result = substring2.substring(from: index2)
                var result2 = substring2.substring(to: index2)
                arrstr.append(result)
                substring2 = result2
                if(result2.characters.count<=3){
                    arrstr.append(result2)
                }
            }
            
        }else{
           arrstr.append(substring2)
        }
        for item in 0..<arrstr.count{
            if(item == 0){
                str = "." + arrstr[item]
                
            }else if(item == 1){
                str = arrstr[item] + str
            }else{
                str = arrstr[item] + "," + str
            }
        }

        return str
    }
    func getfirstdayofmounth() -> String{
        let dateFormatter = DateFormatter()
        let date = Date()
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: date)
        let startOfMonth = Calendar.current.date(from: comp)!
        dateFormatter.dateFormat = "dd-MMM-yy"
        return dateFormatter.string(from: startOfMonth)
    }
    func getdaynow() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yy"
        return formatter.string(from: date)
    }

}
