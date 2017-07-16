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
    lazy var lrcView = UIView()
    
    
    @IBOutlet weak var lrcLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    

    @IBOutlet weak var playOrPauseButton: UIButton!


    weak var timer: Timer?
    
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
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeTimer()
    }
    
    @IBAction func playOrPause(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            QQMusicOperationTool.sharedInstance.playCurrentMusic()
            resumeAnimation()
        } else {
            QQMusicOperationTool.sharedInstance.pauseCurrenMusic()
            pauseAnimation()
        }
    }
    @IBAction func previous(_ sender: UIButton) {
        QQMusicOperationTool.sharedInstance.previousMusic()
        setUpOnceViews()
    }
    @IBAction func next(_ sender: UIButton) {
        QQMusicOperationTool.sharedInstance.nextMusic()
        setUpOnceViews()
    }
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let value = sender.value
        
        QQMusicOperationTool.sharedInstance.changeProgress(progress: value)
    }
    
    @IBAction func close(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}


// MARK:- 初始化
extension QQDetailViewController {
    fileprivate func setUpNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(musicPlayFinished), name: MusicPlayFinishNotification, object: nil)
    }
    
    fileprivate func addLrcView() {
        lrcScrollView.addSubview(lrcView)
    }
    fileprivate func setUpLrcView() {
        var frame = lrcScrollView.bounds
        frame.origin.x += frame.width
        lrcView.frame = frame
        
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
        let lrcModels = QQMusicModelDataTool.getLrcModels(lrcName: musicModel.lrcname)
        
        
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
    
    fileprivate func addTimer() {
        timer = Timer(timeInterval: 1, target: self, selector: #selector(QQDetailViewController.setUpTimesView), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }
    fileprivate func removeTimer() {
        timer?.invalidate()
    }
}

// MARK:- 通知处理
extension QQDetailViewController {
    func musicPlayFinished() {
        playOrPauseButton.isSelected = false
        removeAnimation()
    }
}

// MARK:- 动画
extension QQDetailViewController {
    func addRotationAnimation() {
        
        imageView.layer.removeAllAnimations()
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = 30
        animation.repeatCount = MAXFLOAT
        animation.isRemovedOnCompletion = false
        
        imageView.layer.add(animation, forKey: "rotation")
    }
    
    func pauseAnimation() {
        imageView.layer.pauseAnimate()
    }
    
    func resumeAnimation() {
        imageView.layer.resumeAnimate()
    }
    
    func removeAnimation() {
        imageView.layer.removeAllAnimations()
    }
}

// MARK:- scrollView代理
extension QQDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        
        imageView.alpha = 1 - x/screenW
        lrcLabel.alpha = 1 - x/screenW
    }
}
