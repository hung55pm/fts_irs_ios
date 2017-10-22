//
//  Model_AllTransaction.swift
//  IRSMobile
//
//  Created by hungdn on 10/21/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import Foundation

class Model_AllTransaction: AnyObject {
    
    var PR_KEY : String?
    var TRAN_TYPE_ID : String?
    var TRAN_TYPE_NAME : String?
    var DEALING_DATE : String?
    var SHARE_CLASS_ID : String?
    var SHARE_CLASS_NAME : String?
    var SHARE_SERIES_ID : String?
    var SHARE_SERIES_NAME : String?
    var CURRENCY_ID : String?
    var UNIT_PRICE : Float?
    var QUANTITY : Float?
    var AMOUNT : Float?
    var QUANTITY_BALANCE : String?
}
