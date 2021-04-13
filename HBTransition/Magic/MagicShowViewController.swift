//
//  MagicShowViewController.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class MagicShowViewController: UIViewController ,UINavigationControllerDelegate {

    open var iconView = UIImageView()
    open var icon = UIImage()
    private var contentLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Check"
        view.backgroundColor = .white
        let naviHeight = self.navigationController?.navigationBar.bounds.height ?? 0
        iconView.frame = CGRect.init(x: (view.bounds.width - 280) / 2, y: naviHeight, width: 280, height: 280)
        iconView.image = icon
        view.addSubview(iconView)
        contentLabel.frame = CGRect.init(x: 15, y: iconView.frame.maxY + 15, width: view.bounds.width - 30, height: 100)
        contentLabel.text = "Content"
        contentLabel.textAlignment = .center
        contentLabel.textColor = .red
        contentLabel.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(contentLabel)
    }

    deinit {
        print("\(self)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MagicShowViewController {
    /* @available(iOS 7.0, *)
     optional public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
     */
    //@available(iOS 7.0, *)
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MagicManager.init(pathType: operation == UINavigationControllerOperation.push ? .push: .pop )
    }
}
