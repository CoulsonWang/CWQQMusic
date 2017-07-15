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
    let musicTool = QQMusicTool.sharedInstance
    
    
    var musicModels: [QQMusicModel] = [QQMusicModel]()
    private var currentMusicIndex: Int = -1
    private var currentMusicViewModel: QQMusicViewModel? = QQMusicViewModel()
    
    func getMusicViewModel() -> QQMusicViewModel {
        
        currentMusicViewModel?.musicModel = musicModels[currentMusicIndex]
        currentMusicViewModel?.costTime = musicTool.currentTime
        currentMusicViewModel?.totlaTime = musicTool.totalTime
        currentMusicViewModel?.isPlaying = musicTool.isPlaying
        
        return currentMusicViewModel!
    }
    
    
    func playMusic(musicModel: QQMusicModel) {
        if let index = musicModels.index(of: musicModel) {
            currentMusicIndex = index
        }
        musicTool.playMusic(musicName: musicModel.filename!)
    }
    func changeMusic(musicModel: QQMusicModel) {
        if let index = musicModels.index(of: musicModel) {
            currentMusicIndex = index
        }
        musicTool.changeMusic(musicName: musicModel.filename!)
    }
    
    func pauseCurrenMusic() {
        musicTool.pause()
    }
    
    func playCurrentMusic() {
        let music = musicModels[currentMusicIndex]
        playMusic(musicModel: music)
    }
    
    func nextMusic() {
        let music = (currentMusicIndex == musicModels.count - 1) ? musicModels[0] : musicModels[currentMusicIndex + 1]
        musicTool.isPlaying ? playMusic(musicModel: music) : changeMusic(musicModel: music)
    }
    
    func previousMusic() {
        let music = (currentMusicIndex == 0) ? musicModels[musicModels.count - 1] : musicModels[currentMusicIndex - 1]
        musicTool.isPlaying ? playMusic(musicModel: music) : changeMusic(musicModel: music)
    }
}
