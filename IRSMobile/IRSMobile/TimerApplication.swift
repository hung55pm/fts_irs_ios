//
//  TimerApplication.swift
//  IRSMobile
//
//  Created by hungdn on 1/1/18.
//  Copyright © 2018 Doan Ngoc Hung. All rights reserved.
//

import UIKit

class TimerApplication: UIApplication {
    private var timeoutInSeconds: TimeInterval {
        // 2 minutes
        return 10 * 60
    }
    
    private var idleTimer: Timer?
    
    // resent the timer because there was user interaction
    private func resetIdleTimer() {
        if let idleTimer = idleTimer {
            idleTimer.invalidate()
        }
        
        idleTimer = Timer.scheduledTimer(timeInterval: timeoutInSeconds,
                                         target: self,
                                         selector: #selector(TimerApplication.timeHasExceeded),
                                         userInfo: nil,
                                         repeats: false
        )
    }
    
    // if the timer reaches the limit as defined in timeoutInSeconds, post this notification
    @objc private func timeHasExceeded() {
        print("khong click")
        UIApplication.shared.keyWindow?.rootViewController = LoginViewController()
    }
    
    override func sendEvent(_ event: UIEvent) {
        
        super.sendEvent(event)
        
        if idleTimer != nil {
            self.resetIdleTimer()
        }
        
        if let touches = event.allTouches {
            for touch in touches where touch.phase == UITouchPhase.began {
                print("clcik")
                self.resetIdleTimer()
            }
        }
    }
}
