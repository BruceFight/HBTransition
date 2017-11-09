//
//  TransitionShowViewController.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class TransitionShowViewController: UIViewController ,UINavigationControllerDelegate {
    fileprivate var iconView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        iconView.frame = view.bounds
        iconView.image = #imageLiteral(resourceName: "hope")
        view.addSubview(iconView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension TransitionShowViewController {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionForVcManager.init(pathType: operation == .push ? .push : .pop)
    }
}
