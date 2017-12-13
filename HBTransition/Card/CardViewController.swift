//
//  CardViewController.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/10.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class CardViewController: PublicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "卡片"
        icon = #imageLiteral(resourceName: "iron")
        // Do any additional setup after loading the view.
    }

    override func p() {
        let showVc = CardShowViewController()
        self.navigationController?.delegate = showVc
        self.navigationController?.pushViewController(showVc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
