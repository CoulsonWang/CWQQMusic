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
        
        iconImageView.layer.cornerRadius = iconImageView.bounds.width * 0.5
        iconImageView.layer.masksToBounds = true
    }
    
    class func cellWithTableView(tableView: UITableView) ->QQMusicTableViewCell {
        let cellID = "MusicListCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? QQMusicTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("QQMusicTableViewCell", owner: nil, options: nil)?.first as? QQMusicTableViewCell
        }
        setUpAnimation(cell: cell!)
        
        return cell!
    }

    class func setUpAnimation(cell: QQMusicTableViewCell) {
        cell.layer.removeAllAnimations()
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = cell.bounds.width
        animation.toValue = 0
        animation.duration = 0.2
        animation.repeatCount = 1
        cell.layer.add(animation, forKey: "translation")
    }
}
