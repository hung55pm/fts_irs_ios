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
        
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
