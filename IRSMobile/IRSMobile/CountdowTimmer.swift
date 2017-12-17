//
//  CountdowTimmer.swift
//  IRSMobile
//
//  Created by hungdn on 12/12/17.
//  Copyright © 2017 Doan Ngoc Hung. All rights reserved.
//

import Foundation
class CountdowTimmer{
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
       
    }
    @objc func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        print("\(seconds)") //This will update the label.
        finsh()
        
    }
    
    func pause() {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
        } else {
            runTimer()
            self.resumeTapped = false
        }
    }
    func finsh() {
        if(seconds == 0){
            cancel()
        }
    }
    func cancel() {
        timer.invalidate()
    }
    
    func reset(){
        cancel()
        seconds = 60    //Here we manually enter the restarting point for the seconds, but it would be wiser to make this a variable or constant.
         print("\(seconds)")
    }
    
    func timeStringHMS(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}
