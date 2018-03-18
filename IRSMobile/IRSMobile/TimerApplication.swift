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
        
        return  15 * 60
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
        if let rootViewController = UIApplication.topViewController() {
            if(rootViewController is LoginViewController ||
                rootViewController is SecurityTipsViewController ||
                rootViewController is DataProtectPolicyViewController ||
                rootViewController is FAQsViewController ||
                rootViewController is ForgotPasswordViewController ||
                rootViewController is AboutCroweHorwathViewController ||
                rootViewController is GeneralViewController){
                print("logout11111")
            }else{
                let alert = UIAlertController(title: "Session timeout", message: "Session timeout. Please log in again!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: doSomething))
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }

       
        
    }
    
    override func sendEvent(_ event: UIEvent) {

        super.sendEvent(event)
    
        if idleTimer != nil {
            self.resetIdleTimer()
        }

        if let touches = event.allTouches {
            for touch in touches where touch.phase == UITouchPhase.began {
                if let rootViewController = UIApplication.topViewController() {
                    if(rootViewController is LoginViewController ||
                        rootViewController is SecurityTipsViewController ||
                        rootViewController is DataProtectPolicyViewController ||
                       rootViewController is FAQsViewController ||
                        rootViewController is ForgotPasswordViewController ||
                        rootViewController is AboutCroweHorwathViewController ||
                        rootViewController is GeneralViewController){
                        print("logout")
                    }else{
                         self.resetIdleTimer()
                        print("login")
                }
                }

            }
        }
    }
    func doSomething(action: UIAlertAction) {
       UIApplication.shared.keyWindow?.rootViewController = LoginViewController()
    }

}
extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return topViewController(base: top)
            } else if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}
