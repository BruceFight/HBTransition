//
//  SpringManager.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

enum SpringPathType {
    case present
    case dismiss
}
class SpringManager: NSObject ,UIViewControllerAnimatedTransitioning {
    
    open var pathType = SpringPathType.present
    open var delay: TimeInterval = 0
    open var duration: TimeInterval = 0.6
    
    init(pathType:SpringPathType) {
        self.pathType = pathType
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        switch pathType {
        case .present:
            self.present(transitionContext: transitionContext)
            break
        case .dismiss:
            self.dismiss(transitionContext: transitionContext)
            break
        }
    }
    
    func present(transitionContext:UIViewControllerContextTransitioning) {
        if let fromVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) ,
            let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) {
            let containerView = transitionContext.containerView
            guard let tempView = fromVc.view.snapshotView(afterScreenUpdates: false) else { return }
            tempView.frame = fromVc.view.bounds
            fromVc.view.isHidden = true
            toVc.view.alpha = 0
            toVc.view.frame = CGRect.init(x: 0, y: containerView.bounds.height, width: containerView.bounds.width, height: 400)
            containerView.addSubview(tempView)
            containerView.addSubview(toVc.view)
            // usingSpringWithDamping ,值越小,效果越明显
            // initialSpringVelocity ,值越大,效果越明显
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.35, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                toVc.view.transform = CGAffineTransform.init(translationX: 0, y: -400)
                tempView.transform = CGAffineTransform.init(scaleX: 0.85, y: 0.85)
                toVc.view.alpha = 1
            }, completion: { (true) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                if transitionContext.transitionWasCancelled {
                    fromVc.view.isHidden = false
                    tempView.removeFromSuperview()
                }
            })
        }
    }
    
    func dismiss(transitionContext:UIViewControllerContextTransitioning) {
        if let fromVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) ,
            let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) {
            let containerView = transitionContext.containerView
            let count = containerView.subviews.count
            if count - 2 < 0 { return }
            let tempView = containerView.subviews[count - 2]
            tempView.isHidden = false
            UIView.animate(withDuration: duration, animations: {
                tempView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                fromVc.view.transform = CGAffineTransform.init(translationX: 0, y: 400)
            }, completion: { (true) in
                if transitionContext.transitionWasCancelled {
                    transitionContext.completeTransition(false)
                }else {
                    toVc.view.isHidden = false
                    tempView.removeFromSuperview()
                    transitionContext.completeTransition(true)
                }
            })
        }
    }
    
}

