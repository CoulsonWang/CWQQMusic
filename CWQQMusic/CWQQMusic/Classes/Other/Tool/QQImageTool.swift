//
//  QQImageTool.swift
//  CWQQMusic
//
//  Created by Coulson_Wang on 2017/7/16.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class QQImageTool: NSObject {
    //创建一张带有歌词的图片
    class func createImageWithLrc(originImage: UIImage, lrc: QQLrcModel?) -> UIImage {
        guard let lrc = lrc else { return originImage }
        guard let lrcStr = lrc.lrcSentence else { return originImage }
        
        UIGraphicsBeginImageContext(originImage.size)
        
        originImage.draw(in: CGRect(x: 0, y: 0, width: originImage.size.width, height: originImage.size.height))
        let textRect = CGRect(x: 0, y: 0, width: originImage.size.width, height: 20)
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        let textAttr = [
            NSFontAttributeName : UIFont.systemFont(ofSize: 18),
            NSForegroundColorAttributeName : UIColor.white,
            NSParagraphStyleAttributeName : style
        ]
        (lrcStr as NSString).draw(in: textRect, withAttributes: textAttr)
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resultImage!
    }
}
