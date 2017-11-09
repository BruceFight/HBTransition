//
//  TransitionViewController.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class TransitionViewController: UIViewController ,UINavigationControllerDelegate {

    fileprivate var iconView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Curl"
        view.backgroundColor = .red
        iconView.frame = view.bounds
        iconView.image = #imageLiteral(resourceName: "look")
        iconView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(p))
        iconView.addGestureRecognizer(tap)
        view.addSubview(iconView)
        // Do any additional setup after loading the view.
    }
    
    @objc func p() -> () {
        let showVc = TransitionShowViewController()
        self.navigationController?.delegate = showVc
        self.navigationController?.pushViewController(showVc, animated: true)
    }
    
    deinit {
        print("Deinit -> \(self)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
