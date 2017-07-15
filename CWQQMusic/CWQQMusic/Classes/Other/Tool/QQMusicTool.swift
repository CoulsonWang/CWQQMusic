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
    
    func playMusic(musicName: String) {
        
        createPlayer(musicName: musicName)
        
        player?.prepareToPlay()
        
        player?.play()
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