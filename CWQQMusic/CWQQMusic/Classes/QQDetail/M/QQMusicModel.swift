//
//  QQMusicModel.swift
//  CWQQMusic
//
//  Created by Coulson_Wang on 2017/7/15.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class QQMusicModel: NSObject {
    
    var name: String?
    var filename: String?
    var lrcname: String?
    var singer: String?
    var singerIcon: String?
    var icon: String?
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
