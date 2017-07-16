//
//  QQMusicTool.swift
//  CWQQMusic
//
//  Created by Coulson_Wang on 2017/7/15.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit
import AVFoundation

class QQMusicTool: NSObject {
    
    private var player: AVAudioPlayer?
    
    static let sharedInstance: QQMusicTool = QQMusicTool()
    
    override init() {
        super.init()
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayback)
            try session.setActive(true)
        } catch {
            print(error)
            return
        }
    }
    
    var currentTime: TimeInterval {
        return (player?.currentTime)!
    }
    
    var totalTime: TimeInterval {
        return (player?.duration)!
    }
    
    var isPlaying: Bool {
        return (player?.isPlaying)!
    }
    
    //换歌
    func changeMusic(musicName: String) -> Void {
        createPlayer(musicName: musicName)
        player?.prepareToPlay()
    }
    //播放
    func playMusic(musicName: String) {
        changeMusic(musicName: musicName)
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    private func createPlayer(musicName: String) {
        
        guard let url = Bundle.main.url(forResource: musicName, withExtension: nil) else {
            return
        }
        if player?.url == url {
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
        } catch {
            print(error)
            return
        }
    }
    
    func changeProgress(progress: Float) -> Void {
        let newTime = TimeInterval(Float((player?.duration)!) * progress)
        
        player?.currentTime = newTime
    }
}
extension QQMusicTool: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        NotificationCenter.default.post(name: MusicPlayFinishNotification, object: nil)
    }
}
