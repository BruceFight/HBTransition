//
//  TransitionCollectionViewCell.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/10.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class TransitionCollectionViewCell: UICollectionViewCell {
    open var image = UIImage() {
        didSet{
            iconView.image = image
        }
    }
    open var about = String() {
        didSet{
            aboutLabel.text = about
        }
    }
    open var subType : CATransitionSubType = .fromLeft
    open var type : CATransitionType = .Fade {
        didSet{
            if type == .Fade {
                iconView.image = ViewController.images[Int(arc4random_uniform(UInt32(ViewController.images.count)))]
            }
            TransitionManager.instance.transition(view: iconView, type: type.type, subType: subType.type, start: nil, end: nil)
        }
    }
    fileprivate var iconView = UIImageView()
    fileprivate var aboutLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(iconView)
        aboutLabel.text = "Describe"
        aboutLabel.textColor = .gray
        aboutLabel.textAlignment = .center
        aboutLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(aboutLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let iconWidth = frame.width * 0.7
        let iconHeight = frame.height * 0.7
        iconView.frame = CGRect.init(x: (frame.width - iconWidth) / 2, y: 0, width: iconWidth, height: iconHeight)
        aboutLabel.frame = CGRect.init(x: 0, y: iconView.frame.maxY, width: frame.width, height: frame.height - iconHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
