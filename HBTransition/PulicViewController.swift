//
//  PulicViewController.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/10.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class PulicViewController: UIViewController {

    open var icon : UIImage = #imageLiteral(resourceName: "yeah") {
        didSet{
            iconView.image = icon
        }
    }
    open var iconView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        iconView.frame = view.bounds
        iconView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(p))
        iconView.addGestureRecognizer(tap)
        view.addSubview(iconView)
        // Do any additional setup after loading the view.
    }
    
    @objc func p() -> () {
        print("Do")
    }
    
    deinit {
        print("Deinit -> \(self)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
