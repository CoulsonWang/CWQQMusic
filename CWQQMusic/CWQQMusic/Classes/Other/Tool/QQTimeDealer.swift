//
//  QQTimeDealer.swift
//  CWQQMusic
//
//  Created by Coulson_Wang on 2017/7/15.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class QQTimeDealer: NSObject {
    
    class func getFormatTime(timeInterval: TimeInterval) -> String {
        let min = Int(timeInterval) / 60
        let sec = Int(timeInterval) % 60
        
        return String(format: "%02d:%02d", min,sec)
        
    }
    
    class func getTimeInterval(formatTime: String) -> TimeInterval {
        let minAndSec = formatTime.components(separatedBy: ":")
        if minAndSec.count != 2 {
            return 0
        }
        let min = TimeInterval(minAndSec[0]) ?? 0
        let sec = TimeInterval(minAndSec[1]) ?? 0
        
        return min * 60 + sec
    }
}
