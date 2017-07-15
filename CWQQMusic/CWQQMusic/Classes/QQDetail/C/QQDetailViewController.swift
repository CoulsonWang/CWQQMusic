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
    
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var singerNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var totalTimeLabel: UILabel!
    lazy var lrcView = UIView()
    
    
    @IBOutlet weak var lrcLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    

    @IBOutlet weak var playOrPauseButton: UIButton!


    var timer: Timer?
    
    
}

extension QQDetailViewController {
    override func viewDidLoad() {
        addLrcView()
        setUpLrcScrollView()
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
    }
    @IBAction func previous(_ sender: UIButton) {
        setUpOnceViews()
    }
    @IBAction func next(_ sender: UIButton) {
        setUpOnceViews()
    }
}


// MARK:- 初始化界面
extension QQDetailViewController {
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
    
    fileprivate func setUpImageView() {
        imageView.layer.cornerRadius = imageView.bounds.width * 0.5
        imageView.layer.masksToBounds = true
    }
    
    fileprivate func setUpSlider() {
        slider.setThumbImage(#imageLiteral(resourceName: "player_slider_playback_thumb"), for: .normal)
        slider.maximumTrackTintColor = UIColor.white
    }
    
    fileprivate func setUpOnceViews() {
        
    }
    
    @objc fileprivate func setUpTimesView() {
        
    }
    
    fileprivate func addTimer() {
        timer = Timer(timeInterval: 1, target: self, selector: #selector(QQDetailViewController.setUpTimesView), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }
    fileprivate func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
}


// MARK:- 动画
extension QQDetailViewController {
    
}


extension QQDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        
        imageView.alpha = 1 - x/screenW
        lrcLabel.alpha = 1 - x/screenW
    }
}
