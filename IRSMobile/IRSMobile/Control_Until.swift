//
//  Control_Until.swift
//  IRSMobile
//
//  Created by hungdn on 12/10/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import Foundation


class Control_until{

    func gettotalrem(arr : [Model_rem_Cash])-> [Model_total] {
        var arrtotal = [Model_total]()
        
        
      
        
         if (arr.count > 0) {
              var model = Model_total()
                model.curent = arr[0].CURRENCY_ID
            if(arr[0].CURRENCY_ID == "USD"){
                model.curent_display = "$"
            }else{
                model.curent_display = arr[0].CURRENCY_ID
            }
            arrtotal.append(model)
            
            for i in 0..<arr.count{
                var dem = 0
                for j in 0..<arrtotal.count{
                    if(arr[i].CURRENCY_ID == arrtotal[j].curent){
                        break
                    }else{
                        dem += 1
                    }
                    
                    if(dem != arrtotal.count){
                        var model1 = Model_total()
                        model1.curent = arr[0].CURRENCY_ID
                        if(arr[0].CURRENCY_ID == "USD"){
                            model1.curent_display = "$"
                        }else{
                            model1.curent_display = arr[0].CURRENCY_ID
                        }
                        
                        arrtotal.append(model1)
                    }
                }
            }
            
        }
        return arrtotal
    }
    
    
    func gettotalsub(arr : [Model_sub_Cash])-> [Model_total] {
        var arrtotal = [Model_total]()
        
        if (arr.count > 0) {
            var model = Model_total()
            model.curent = arr[0].CURRENCY_ID
            if(arr[0].CURRENCY_ID == "USD"){
                model.curent_display = "$"
            }else{
                model.curent_display = arr[0].CURRENCY_ID
            }
            arrtotal.append(model)
            
            for i in 0..<arr.count{
                var dem = 0
                for j in 0..<arrtotal.count{
                    if(arr[i].CURRENCY_ID == arrtotal[j].curent){
                        break
                    }else{
                        dem += 1
                    }
                    
                    if(dem != arrtotal.count){
                        var model1 = Model_total()
                        model1.curent = arr[0].CURRENCY_ID
                        if(arr[0].CURRENCY_ID == "USD"){
                            model1.curent_display = "$"
                        }else{
                            model1.curent_display = arr[0].CURRENCY_ID
                        }
                        
                        arrtotal.append(model1)
                    }
                }
            }
            
        }
        return arrtotal
    }
    
    
    func gettotalportfolio(arr : [Model_Portfolio])-> [Model_total] {
        var arrtotal = [Model_total]()
        
        if (arr.count > 0) {
            var model = Model_total()
            model.curent = arr[0].CURRENCY_ID
            if(arr[0].CURRENCY_ID == "USD"){
                model.curent_display = "$"
            }else{
                model.curent_display = arr[0].CURRENCY_ID
            }
            arrtotal.append(model)
            
            for i in 0..<arr.count{
                var dem = 0
                for j in 0..<arrtotal.count{
                    if(arr[i].CURRENCY_ID == arrtotal[j].curent){
                        break
                    }else{
                        dem += 1
                    }
                    
                    if(dem != arrtotal.count){
                        var model1 = Model_total()
                        model1.curent = arr[0].CURRENCY_ID
                        if(arr[0].CURRENCY_ID == "USD"){
                            model1.curent_display = "$"
                        }else{
                            model1.curent_display = arr[0].CURRENCY_ID
                        }
                        
                        arrtotal.append(model1)
                    }
                }
            }
            
        }
        return arrtotal
    }

    
    func gettotalportfoliodetail(arr : [Model_Portfolio])-> [Model_total] {
        var arrtotal = [Model_total]()
        
        if (arr.count > 0) {
            var model = Model_total()
            model.curent = arr[0].CURRENCY_ID
            if(arr[0].CURRENCY_ID == "USD"){
                model.curent_display = "$"
            }else{
                model.curent_display = arr[0].CURRENCY_ID
            }
            arrtotal.append(model)
            
            for i in 0..<arr.count{
                var dem = 0
                for j in 0..<arrtotal.count{
                    if(arr[i].CURRENCY_ID == arrtotal[j].curent){
                        break
                    }else{
                        dem += 1
                    }
                    
                    if(dem != arrtotal.count){
                        var model1 = Model_total()
                        model1.curent = arr[0].CURRENCY_ID
                        if(arr[0].CURRENCY_ID == "USD"){
                            model1.curent_display = "$"
                        }else{
                            model1.curent_display = arr[0].CURRENCY_ID
                        }
                        
                        arrtotal.append(model1)
                    }
                }
            }
            
        }
        return arrtotal
    }
    
    var counter = 30
    func countdowtimmer() {
        var time = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        //you code, this is an example
        if counter > 0 {
            print("\(counter) seconds to the end of the world")
            counter -= 1
        }
    }
    
}
