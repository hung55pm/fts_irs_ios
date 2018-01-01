//
//  main.swift
//  IRSMobile
//
//  Created by hungdn on 1/1/18.
//  Copyright © 2018 Doan Ngoc Hung. All rights reserved.
//

import Foundation
import UIKit

UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
        .bindMemory(
            to: UnsafeMutablePointer<Int8>.self,
            capacity: Int(CommandLine.argc)),
    NSStringFromClass(TimerApplication.self),
    NSStringFromClass(AppDelegate.self)
)
