//
//  QQLrcTableViewCell.swift
//  CWQQMusic
//
//  Created by Coulson_Wang on 2017/7/16.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class QQLrcTableViewCell: UITableViewCell {

    @IBOutlet private weak var lrcLabel: QQLrcLabel!
    
    var lrcContent:String? {
        didSet {
            lrcLabel.text = lrcContent
        }
    }
    
    var progress: CGFloat = 0.0 {
        didSet {
            lrcLabel.radio = progress
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func cellWithTableView(tableView: UITableView) -> QQLrcTableViewCell {
        let cellID = "lrcCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? QQLrcTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("QQLrcTableViewCell", owner: nil, options: nil)?.first as? QQLrcTableViewCell
            cell?.backgroundColor = UIColor.clear
            cell?.lrcLabel?.textAlignment = .center
            cell?.lrcLabel?.textColor = UIColor.white
        }
        return cell!

    }
}
