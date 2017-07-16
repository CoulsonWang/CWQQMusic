//
//  QQDetailViewController.swift
//  CWQQMusic
//
//  Created by Coulson_Wang on 2017/7/15.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

let screenW = UIScreen.main.bounds.width


class QQDetailViewController: UIViewController {
    
    @IBOutlet weak var lrcScrollView: UIScrollView!
    
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var singerNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var totalTimeLabel: UILabel!
    lazy var lrcTVC: QQLrcTableViewController = QQLrcTableViewController()
    
    
    @IBOutlet weak var lrcLabel: QQLrcLabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    

    @IBOutlet weak var playOrPauseButton: UIButton!


    fileprivate var timer: Timer?
    fileprivate var displayLink: CADisplayLink?
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK:- 生命周期与业务逻辑
extension QQDetailViewController {
    override func viewDidLoad() {
        addLrcView()
        setUpLrcScrollView()
        setUpSlider()
        
        setUpNotification()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpLrcView()
        setUpImageView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpOnceViews()
        addTimer()
        addLink()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeTimer()
        removeLink()
    }
    
    @IBAction fileprivate func playOrPause(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            QQMusicOperationTool.sharedInstance.playCurrentMusic()
            resumeAnimation()
        } else {
            QQMusicOperationTool.sharedInstance.pauseCurrenMusic()
            pauseAnimation()
        }
    }
    @IBAction fileprivate func previous(_ sender: UIButton) {
        QQMusicOperationTool.sharedInstance.previousMusic()
        setUpOnceViews()
    }
    @IBAction fileprivate func next(_ sender: UIButton) {
        QQMusicOperationTool.sharedInstance.nextMusic()
        setUpOnceViews()
    }
    @IBAction private func sliderValueChanged(_ sender: UISlider) {
        let value = sender.value
        
        QQMusicOperationTool.sharedInstance.changeProgress(progress: value)
    }
    
    @IBAction private func close(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}


// MARK:- 初始化
extension QQDetailViewController {
    fileprivate func setUpNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(musicPlayFinished), name: MusicPlayFinishNotification, object: nil)
    }
    
    fileprivate func addLrcView() {
        lrcTVC.tableView.backgroundColor = UIColor.clear
        lrcScrollView.addSubview(lrcTVC.tableView)
    }
    fileprivate func setUpLrcView() {
        var frame = lrcScrollView.bounds
        frame.origin.x = frame.width
        lrcTVC.tableView.frame = frame
        
        lrcScrollView.contentSize = CGSize(width: 2 * frame.width, height: 0)
    }
    fileprivate func setUpLrcScrollView() {
        lrcScrollView.isPagingEnabled = true
        lrcScrollView.showsHorizontalScrollIndicator = false
        lrcScrollView.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func setUpImageView() {
        imageView.layer.cornerRadius = imageView.bounds.width * 0.5
        imageView.layer.masksToBounds = true
    }
    
    fileprivate func setUpSlider() {
        slider.setThumbImage(#imageLiteral(resourceName: "player_slider_playback_thumb"), for: .normal)
        slider.maximumTrackTintColor = UIColor.white
        slider.tintColor = QQMusicTintColor
    }
    
    fileprivate func setUpOnceViews() {
        let musicViewModel = QQMusicOperationTool.sharedInstance.getMusicViewModel()
        guard let musicModel = musicViewModel.musicModel else { return }
        
        backgroundImageView.image = UIImage(named: musicModel.icon!)
        imageView.image = UIImage(named: musicModel.icon!)
        songNameLabel.text = musicModel.name
        singerNameLabel.text = musicModel.singer
        totalTimeLabel.text = QQTimeDealer.getFormatTime(timeInterval: musicViewModel.totlaTime)
        playOrPauseButton.isSelected = musicViewModel.isPlaying
        lrcTVC.lrcModels = QQMusicModelDataTool.getLrcModels(lrcName: musicModel.lrcname)
        
        addRotationAnimation()
        if musicViewModel.isPlaying {
            resumeAnimation()
        } else {
            pauseAnimation()
        }
    }
    
    @objc fileprivate func setUpTimesView() {
        let musicViewModel = QQMusicOperationTool.sharedInstance.getMusicViewModel()
        slider.value = musicViewModel.progress
        currentTimeLabel.text = QQTimeDealer.getFormatTime(timeInterval: musicViewModel.costTime)
    }
    
    @objc private func updateLrcLabel() {
        let time = QQMusicOperationTool.sharedInstance.getMusicViewModel().costTime
        let lrcModels = lrcTVC.lrcModels
        let (lrcModel,row) = QQMusicModelDataTool.getCurrentLrcModel(currentTime: time, lrcModels: lrcModels)
        if let lrcModel = lrcModel {
            lrcLabel.text = lrcModel.lrcSentence
            lrcLabel.radio = CGFloat((time - lrcModel.beginTime) / (lrcModel.endTime - lrcModel.beginTime))
            lrcTVC.progress = lrcLabel.radio
        }
        
        if let row = row {
            lrcTVC.scrollRow = row
        }
        
        QQMusicOperationTool.sharedInstance.setUpLockMessage()
    }
    
    fileprivate func addTimer() {
        timer = Timer(timeInterval: 1, target: self, selector: #selector(QQDetailViewController.setUpTimesView), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoopMode.defaultRunLoopMode)
    }
    fileprivate func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    fileprivate func addLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateLrcLabel))
        displayLink?.add(to: RunLoop.current, forMode: .commonModes)
    }
    
    fileprivate func removeLink() {
        displayLink?.invalidate()
        displayLink = nil
    }
}

// MARK:- 通知处理
extension QQDetailViewController {
    @objc fileprivate func musicPlayFinished() {
        playOrPauseButton.isSelected = false
        removeAnimation()
    }
}

// MARK:- 动画
extension QQDetailViewController {
    fileprivate func addRotationAnimation() {
        
        imageView.layer.removeAllAnimations()
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = 30
        animation.repeatCount = MAXFLOAT
        animation.isRemovedOnCompletion = false
        
        imageView.layer.add(animation, forKey: "rotation")
    }
    
    fileprivate func pauseAnimation() {
        imageView.layer.pauseAnimate()
    }
    
    fileprivate func resumeAnimation() {
        imageView.layer.resumeAnimate()
    }
    
    fileprivate func removeAnimation() {
        imageView.layer.removeAllAnimations()
    }
}

// MARK:- scrollView代理
extension QQDetailViewController: UIScrollViewDelegate {
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        
        imageView.alpha = 1 - x/screenW
        lrcLabel.alpha = 1 - x/screenW
    }
}


// MARK:- 处理锁屏事件
extension QQDetailViewController {
    override func remoteControlReceived(with event: UIEvent?) {
        let type = event?.subtype
        switch type! {
        case .remoteControlPlay:
            QQMusicOperationTool.sharedInstance.playCurrentMusic()
        case .remoteControlPause:
            QQMusicOperationTool.sharedInstance.pauseCurrenMusic()
        case .remoteControlNextTrack:
            QQMusicOperationTool.sharedInstance.nextMusic()
        case .remoteControlPreviousTrack:
            QQMusicOperationTool.sharedInstance.previousMusic()
        default:
            return
        }
        setUpOnceViews()
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            QQMusicOperationTool.sharedInstance.nextMusic()
            setUpOnceViews()
        }
    }
}
