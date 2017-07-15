//
//  QQMusicOperationTool.swift
//  CWQQMusic
//
//  Created by Coulson_Wang on 2017/7/15.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class QQMusicOperationTool: NSObject {
    
    class func playMusic(musicModel: QQMusicModel) {
        QQMusicTool.sharedInstance.playMusic(musicName: musicModel.filename!)
    }
}
