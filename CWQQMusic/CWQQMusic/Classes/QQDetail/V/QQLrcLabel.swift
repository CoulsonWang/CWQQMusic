//
//  QQLrcLabel.swift
//  CWQQMusic
//
//  Created by Coulson_Wang on 2017/7/16.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class QQLrcLabel: UILabel {

    var radio: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        QQMusicTintColor.set()
        let fillRect = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width * radio, height: rect.size.height)
        UIRectFillUsingBlendMode(fillRect, CGBlendMode.sourceIn)
    }
    

}
