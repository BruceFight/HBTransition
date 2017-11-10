//
//  SpringViewController.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class SpringViewController: PulicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "弹性"
        view.backgroundColor = .red
        icon = #imageLiteral(resourceName: "yeah")
    }
    
    @objc override func p() -> () {
        let showVc = SpringShowViewController()
        showVc.dismissHandler = {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        self.navigationController?.present(showVc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
