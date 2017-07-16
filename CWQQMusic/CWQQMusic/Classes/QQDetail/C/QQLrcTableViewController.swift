//
//  QQLrcTableViewController.swift
//  CWQQMusic
//
//  Created by Coulson_Wang on 2017/7/16.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class QQLrcTableViewController: UITableViewController {
    
    var lrcModels: [QQLrcModel] = [QQLrcModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.contentInset = UIEdgeInsets(top: tableView.bounds.height * 0.5, left: 0, bottom: tableView.bounds.height * 0.5, right: 0)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lrcModels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "lrcCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
            cell?.backgroundColor = UIColor.clear
            cell?.textLabel?.textAlignment = .center
            cell?.textLabel?.textColor = UIColor.white
        }
        
        cell?.textLabel?.text = lrcModels[indexPath.row].lrcSentence

        return cell!
    }
    



}
