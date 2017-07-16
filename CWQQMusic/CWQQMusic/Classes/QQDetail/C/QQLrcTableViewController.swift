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
    
    var scrollRow = 0 {
        didSet {
            if scrollRow == oldValue {
                return
            }
            let indexPaths = tableView.indexPathsForVisibleRows
            tableView.reloadRows(at: indexPaths!, with: .automatic)
            
            let indePath = IndexPath(row: scrollRow, section: 0)
            tableView.scrollToRow(at: indePath, at: .middle, animated: true)
        }
    }
    
    var progress: CGFloat = 0.0 {
        didSet {
            let indePath = IndexPath(row: scrollRow, section: 0)
            
            let cell = tableView.cellForRow(at: indePath) as? QQLrcTableViewCell
            
            cell?.progress = progress
            
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
        let cell = QQLrcTableViewCell.cellWithTableView(tableView: tableView)
        
        cell.lrcContent = lrcModels[indexPath.row].lrcSentence
        
        if indexPath.row == scrollRow {
            cell.progress = progress
        } else {
            cell.progress = 0
        }
        
        return cell
    }
    



}
