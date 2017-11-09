//
//  SpringViewController.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class SpringViewController: UIViewController {

    fileprivate var iconView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "弹性"
        view.backgroundColor = .red
        iconView.frame = view.bounds
        iconView.image = #imageLiteral(resourceName: "yeah")
        iconView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(p))
            iconView.addGestureRecognizer(tap)
        view.addSubview(iconView)
    }
    
    @objc func p() -> () {
        let showVc = SpringShowViewController()
        showVc.dismissHandler = {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        self.navigationController?.present(showVc, animated: true, completion: nil)
    }
    
    deinit {
        print("Deinit -> \(self)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
