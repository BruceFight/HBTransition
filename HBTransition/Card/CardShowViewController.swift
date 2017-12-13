//
//  CardShowViewController.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/10.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class CardShowViewController: PublicViewController ,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        icon = #imageLiteral(resourceName: "spider")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardManager.init(pathType: operation == UINavigationControllerOperation.push ? .push : .pop )
    }
}
