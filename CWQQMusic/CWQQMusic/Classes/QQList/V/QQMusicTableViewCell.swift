//
//  QQMusicTableViewCell.swift
//  CWQQMusic
//
//  Created by Coulson_Wang on 2017/7/15.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class QQMusicTableViewCell: UITableViewCell {
    
    var musicItem: QQMusicModel? {
        didSet {
            iconImageView.image = UIImage(named: (musicItem?.singerIcon)!)
            songNameLabel.text = musicItem?.name
            singerNameLabel.text = musicItem?.singer
        }
    }
    

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var songNameLabel: UILabel!
    
    @IBOutlet weak var singerNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func cellWithTableView(tableView: UITableView) ->QQMusicTableViewCell {
        let cellID = "MusicListCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? QQMusicTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("QQMusicTableViewCell", owner: nil, options: nil)?.first as? QQMusicTableViewCell
        }
        return cell!
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
