//
//  OpenDoorViewController.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/10.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class OpenDoorViewController: PulicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        icon = #imageLiteral(resourceName: "widow")
        
    }
    
    override func p() {
        let showVc = OpenDoorShowViewController()
        self.navigationController?.delegate = showVc
        self.navigationController?.pushViewController(showVc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
