//
//  QQListTableViewController.swift
//  CWQQMusic
//
//  Created by Coulson_Wang on 2017/7/15.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class QQListTableViewController: UITableViewController {
    
    var models: [QQMusicModel] = [QQMusicModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        QQMusicModelDataTool.getMusicModels { (models) in
            if let models = models {
                self.models = models
            }
        }
        
        setUpTableView()
    }


    


}

// MARK:- 数据源和代理
extension QQListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = QQMusicTableViewCell.cellWithTableView(tableView: tableView)
        cell.musicItem = models[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = models[indexPath.row]
        QQMusicOperationTool.playMusic(musicModel: model)
        performSegue(withIdentifier: "listToDetail", sender: model)
    }
}

// MARK:- 界面相关
extension QQListTableViewController {
    
    fileprivate func setUpTableView() {
        setUpBackground()
        
        tableView.rowHeight = 60
        
        tableView.separatorStyle = .none
        
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    private func setUpBackground() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "QQListBack"))
        tableView.backgroundView = imageView
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
