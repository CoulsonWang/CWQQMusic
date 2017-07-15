//
//  QQMusicViewModel.swift
//  CWQQMusic
//
//  Created by Coulson_Wang on 2017/7/15.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class QQMusicViewModel: NSObject {
    var musicModel: QQMusicModel?
    
    var costTime: TimeInterval = 0
    
    var totlaTime: TimeInterval = 0
    
    var progress: Float {
        return Float(costTime / totlaTime)
    }
    
    var isPlaying: Bool = false
    
}
