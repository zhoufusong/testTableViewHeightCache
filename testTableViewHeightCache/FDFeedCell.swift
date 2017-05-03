//
//  FDFeedCell.swift
//  testTableViewHeightCache
//
//  Created by apple on 17/4/27.
//  Copyright © 2017年 XGHL. All rights reserved.
//

import UIKit

class FDFeedCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var entity:FDFeedEntity?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.bounds = UIScreen.main.bounds
        
        // Initialization code
    }
    
    func setEntity(entity:FDFeedEntity){
        self.entity=entity
        self.titleLabel.text = entity.title
        self.contentLabel.text = entity.content
        self.contentImageView.image = (entity.imageName?.characters.count)! > 0 ? UIImage.init(named: entity.imageName!) : nil
        self.usernameLabel.text = entity.username
        self.timeLabel.text = entity.time
    
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var totalHeight:CGFloat = 0;
        totalHeight += self.titleLabel.sizeThatFits(size).height
        totalHeight += self.contentLabel.sizeThatFits(size).height;
        totalHeight += self.contentImageView.sizeThatFits(size).height;
        totalHeight += self.usernameLabel.sizeThatFits(size).height;
        totalHeight += 40; // margins
        return CGSize.init(width: size.width, height: totalHeight)

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
