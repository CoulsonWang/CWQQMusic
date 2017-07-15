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

}
