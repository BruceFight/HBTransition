//
//  MagicTableViewCell.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class MagicTableViewCell: UITableViewCell {

    open var iconView = UIImageView()
    open var indexLabel = UILabel()
    open var contentLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(iconView)
        indexLabel.text = "MagicTableViewCell"
        indexLabel.textColor = .purple
        indexLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(indexLabel)
        contentLabel.text = "Content ... "
        contentLabel.textColor = .purple
        contentLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(contentLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconView.frame = CGRect.init(x: 15, y: 10, width: 100, height: 80)
        indexLabel.frame = CGRect.init(x: iconView.frame.maxX + 10, y: 10, width: frame.width - 140, height: 12)
        contentLabel.frame = CGRect.init(x: iconView.frame.maxX + 10, y: indexLabel.frame.maxY + 10, width: indexLabel.frame.width, height: 68)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
