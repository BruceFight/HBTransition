//
//  OpenDoorShowViewController.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/10.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class OpenDoorShowViewController: PulicViewController ,UINavigationControllerDelegate {

    fileprivate var pan : UIPanGestureRecognizer?
    override func viewDidLoad() {
        super.viewDidLoad()
        icon = #imageLiteral(resourceName: "holk")
        pan = UIPanGestureRecognizer.init(target: self, action: #selector(move(pan:)))
        if let pan = self.pan {
            view.addGestureRecognizer(pan)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return OpenDoorManager.init(pathType: operation == UINavigationControllerOperation.push ? .push : .pop )
    }
//UIPercentDrivenInteractiveTransition
    @objc func move(pan:UIPanGestureRecognizer) -> () {
        var percent : CGFloat = 0
        let x = pan.translation(in: view).x
        percent = x / view.frame.width
        switch pan.state {
        case .began:
            self.navigationController?.popViewController(animated: true)
            break
        case .changed:
            /*
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
             */
            
            break
        case .ended:
            
            break
        default:break
        }
    }
}

