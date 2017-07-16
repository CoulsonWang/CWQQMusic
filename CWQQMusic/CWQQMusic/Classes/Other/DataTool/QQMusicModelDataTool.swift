//
//  QQMusicModelDataTool.swift
//  CWQQMusic
//
//  Created by Coulson_Wang on 2017/7/15.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class QQMusicModelDataTool: NSObject {
    
    class func getMusicModels(result: ([QQMusicModel]?)->()) -> Void {
        guard let path = Bundle.main.path(forResource: "Musics.plist", ofType: nil) else {
            result(nil)
            return
        }
        
        guard let dictArray = NSArray(contentsOfFile: path) else {
            result(nil)
            return
        }
        
        var models = [QQMusicModel]()
        
        for dict in dictArray {
            let resultDict = dict as! [String : Any]
            let model = QQMusicModel(dict: resultDict)
            models.append(model)
        }
        
        result(models)
    }
    
    class func getLrcModels(lrcName: String?) -> [QQLrcModel] {
        if lrcName == nil {
            return [QQLrcModel]()
        }
        
        guard let path = Bundle.main.path(forResource: lrcName, ofType: nil) else {
            return [QQLrcModel]()
        }
        
        var lrcContent = ""
        do {
            lrcContent = try String(contentsOfFile: path)
        } catch {
            print(error)
            return [QQLrcModel]()
        }
        //分割每一行
        let lineArray = lrcContent.components(separatedBy: "\n")
        var lrcModels = [QQLrcModel]()
        for line in lineArray {
            //过滤垃圾数据
            if line.contains("[ti:]") || line.contains("[ar:]") || line.contains("[al:]") {
                continue
            }
            //过滤括号
            let resultStr = line.replacingOccurrences(of: "[", with: "")
            let timeAndLrc = resultStr.components(separatedBy: "]")
            if timeAndLrc.count != 2 {
                continue
            }
            let timeStr = timeAndLrc[0]
            let lrcStr = timeAndLrc[1]
            
            let lrcModel = QQLrcModel()
            lrcModel.beginTime = QQTimeDealer.getTimeInterval(formatTime: timeStr)
            lrcModel.lrcSentence = lrcStr
            
            lrcModels.append(lrcModel)
        }
        //处理结束时间
        let count = lrcModels.count
        for i in 0..<count {
            if i == count - 1 {
                continue
            }
            let lrcModel = lrcModels[i]
            let nextModel = lrcModels[i+1]
            lrcModel.endTime = nextModel.beginTime
        }
        
        
        return lrcModels
    }
    
    class func getCurrentLrcModel(currentTime: TimeInterval, lrcModels: [QQLrcModel]) -> QQLrcModel? {
        for lrcModel in lrcModels {
            if currentTime >= lrcModel.beginTime && currentTime <= lrcModel.endTime {
                return lrcModel
            }
        }
        return nil
    }
}
