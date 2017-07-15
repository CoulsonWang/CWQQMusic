//
//  QQMusicOperationTool.swift
//  CWQQMusic
//
//  Created by Coulson_Wang on 2017/7/15.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class QQMusicOperationTool: NSObject {
    static let sharedInstance = QQMusicOperationTool()
    
    var musicModels: [QQMusicModel] = [QQMusicModel]()
    var currentMusicIndex: Int = -1
    
    
    func playMusic(musicModel: QQMusicModel) {
        QQMusicTool.sharedInstance.playMusic(musicName: musicModel.filename!)
        if let index = musicModels.index(of: musicModel) {
            currentMusicIndex = index
        }
    }
    
    func pauseCurrenMusic() {
        QQMusicTool.sharedInstance.pause()
    }
    
    func playCurrentMusic() {
        let music = musicModels[currentMusicIndex]
        playMusic(musicModel: music)
    }
    
    func nextMusic() {
        let music = (currentMusicIndex == musicModels.count - 1) ? musicModels[0] : musicModels[currentMusicIndex + 1]
        playMusic(musicModel: music)
    }
    
    func previousMusic() {
        let music = (currentMusicIndex == 0) ? musicModels[musicModels.count - 1] : musicModels[currentMusicIndex - 1]
        playMusic(musicModel: music)
    }
}
