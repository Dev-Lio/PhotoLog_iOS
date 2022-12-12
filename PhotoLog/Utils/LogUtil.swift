//
//  LogUtil.swift
//  TimeCapsule
//
//  Created by Lio on 2022/11/18.
//

import Foundation

class LogUitl {
    
    static var logOn = true
    
    static func printLog(message : String) {
        if logOn {
            print(message)
        }
    }
    
}
