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
}
