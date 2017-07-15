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
    
    var currentTime: TimeInterval {
        return (player?.currentTime)!
    }
    
    var totalTime: TimeInterval {
        return (player?.duration)!
    }
    
    var isPlaying: Bool {
        return (player?.isPlaying)!
    }
    
    func changeMusic(musicName: String) -> Void {
        createPlayer(musicName: musicName)
        player?.prepareToPlay()
    }
    
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
        } catch {
            print(error)
            return
        }
    }
    
    
}
