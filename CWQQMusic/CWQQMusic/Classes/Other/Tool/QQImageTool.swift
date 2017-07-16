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
    
    class func createImageWithLrcs(originImage: UIImage, lrcs: [QQLrcModel?]) -> UIImage {
        if lrcs.count != 3 {
            return originImage
        }
        let preLrc = lrcs[0]?.lrcSentence ?? ""
        let currentLrc = lrcs[1]?.lrcSentence ?? ""
        let nextLrc = lrcs[2]?.lrcSentence ?? ""
        
        UIGraphicsBeginImageContext(originImage.size)
        
        originImage.draw(in: CGRect(x: 0, y: 0, width: originImage.size.width, height: originImage.size.height))
        let preRect = CGRect(x: 0, y: 0, width: originImage.size.width, height: 14)
        let curRect = CGRect(x: 0, y: 20, width: originImage.size.width, height: 14)
        let nextRect = CGRect(x: 0, y: 40, width: originImage.size.width, height: 14)
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        let textAttr = [
            NSFontAttributeName : UIFont.systemFont(ofSize: 14),
            NSForegroundColorAttributeName : UIColor.white,
            NSParagraphStyleAttributeName : style
        ]
        (preLrc as NSString).draw(in: preRect, withAttributes: textAttr)
        (currentLrc as NSString).draw(in: curRect, withAttributes: textAttr)
        (nextLrc as NSString).draw(in: nextRect, withAttributes: textAttr)
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resultImage!
    }
}
