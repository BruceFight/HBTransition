//
//  OpenDoorShowViewController.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/10.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class OpenDoorShowViewController: PublicViewController ,UINavigationControllerDelegate {

    private var _operation: UINavigationControllerOperation = .push
    private var _popManager = InteractionManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        icon = #imageLiteral(resourceName: "holk")
        _popManager.observeGestureFor(vc: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        _operation = operation
        return OpenDoorManager.init(pathType: operation == UINavigationControllerOperation.push ? .push: .pop )
    }
    
}

class InteractionManager: UIPercentDrivenInteractiveTransition {
    
    private var pan: UIPanGestureRecognizer?
    weak private var vc: UIViewController?
    func observeGestureFor(vc:UIViewController) {
        self.vc = vc
        self.pan = UIPanGestureRecognizer.init(target: self, action: #selector(move(pan:)))
        if let pan = self.pan {
            vc.view.addGestureRecognizer(pan)
        }
    }
    
    @objc func move(pan:UIPanGestureRecognizer) {
        var percent: CGFloat = 0
        var x: CGFloat = 0
        if let vc = self.vc {
            x = pan.translation(in: vc.view).x
            percent = x / (vc.view.frame.width)
        }
        switch pan.state {
        case .began:
            self.vc?.navigationController?.popViewController(animated: true)
            break
        case .changed:
            self.update(percent)
            break
        case .ended:
            
            break
        default:break
        }
    }
}
