//
//  QQMusicOperationTool.swift
//  CWQQMusic
//
//  Created by Coulson_Wang on 2017/7/15.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit
import MediaPlayer

class QQMusicOperationTool: NSObject {
    
    var lastModel: QQLrcModel? = QQLrcModel()
    
    
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
    
    func changeProgress(progress: Float) -> Void {
        musicTool.changeProgress(progress: progress)
    }
    
    
    //设置锁屏界面
    func setUpLockMessage() {
        let musicViewModel = getMusicViewModel()
        
        let musciName = musicViewModel.musicModel?.name ?? ""
        let singerName = musicViewModel.musicModel?.singer ?? ""
        let costTime = musicViewModel.costTime
        let totalTime = musicViewModel.totlaTime
        

        let lrcModels = QQMusicModelDataTool.getLrcModels(lrcName: musicViewModel.musicModel?.lrcname)
        
        
        let currentLrcModel = QQMusicModelDataTool.getCurrentLrcModel(currentTime: costTime, lrcModels: lrcModels).lrcModel
        if lastModel == currentLrcModel {
            return
        } else {
            lastModel = currentLrcModel
        }
        
        let currentIndex = lrcModels.index(of: currentLrcModel!)!
        let previousLrcModel = (currentIndex == 0) ? nil : lrcModels[currentIndex-1]
        let nextLrcModel = (currentIndex == lrcModels.count-1) ? nil : lrcModels[currentIndex+1]
        

        let imageName = musicViewModel.musicModel?.icon ?? ""
        let originImage = UIImage(named: imageName) ?? UIImage()
        let image = QQImageTool.createImageWithLrcs(originImage: originImage, lrcs: [previousLrcModel,currentLrcModel,nextLrcModel])
        
        let artWork = MPMediaItemArtwork(boundsSize: CGSize(width: image.size.width, height: image.size.height)) { (size) -> UIImage in
            return image
        }
        
        let center = MPNowPlayingInfoCenter.default()
        center.nowPlayingInfo = [
            MPMediaItemPropertyAlbumTitle : musciName,
            MPMediaItemPropertyArtist : singerName,
            MPNowPlayingInfoPropertyElapsedPlaybackTime : costTime,
            MPMediaItemPropertyPlaybackDuration : totalTime,
            MPMediaItemPropertyArtwork : artWork
        ]
        
        UIApplication.shared.beginReceivingRemoteControlEvents()
    }
    
    
}
