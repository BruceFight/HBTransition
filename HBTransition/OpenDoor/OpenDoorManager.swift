//
//  OpenDoorManager.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/10.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class OpenDoorManager: NSObject ,UIViewControllerAnimatedTransitioning {
    
    open var pathType = MagicPathType.push
    open var delay: TimeInterval = 0
    open var duration: TimeInterval = 0.8
    
    init(pathType:MagicPathType) {
        self.pathType = pathType
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        switch pathType {
        case .push:
            self.push(transitionContext: transitionContext)
            break
        case .pop:
            self.pop(transitionContext: transitionContext)
            break
        }
    }
    
    func push(transitionContext:UIViewControllerContextTransitioning) {
        if let fromVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? OpenDoorViewController ,
        let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? OpenDoorShowViewController {
            
            let containerView = transitionContext.containerView
            fromVc.view.frame = containerView.bounds
            fromVc.view.isHidden = true
            toVc.view.frame = containerView.bounds
            toVc.view.transform = CGAffineTransform.init(scaleX: 0.75, y: 0.75)
            containerView.addSubview(toVc.view)
            let halfWidth = containerView.bounds.width / 2
            let leftFrame = CGRect.init(x: 0, y: 0, width: halfWidth, height: fromVc.view.bounds.height)
            let rightFrame = CGRect.init(x:halfWidth , y: 0, width: halfWidth, height: fromVc.view.bounds.height)
            if let leftPart = fromVc.view.resizableSnapshotView(from: leftFrame, afterScreenUpdates: false, withCapInsets: .zero) ,
            let rightPart = fromVc.view.resizableSnapshotView(from: rightFrame, afterScreenUpdates: false, withCapInsets: .zero) {
                leftPart.frame = leftFrame
                rightPart.frame = rightFrame
                containerView.addSubview(leftPart)
                containerView.addSubview(rightPart)
                //UIView.animate(withDuration: duration, animations: {
                UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.35, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    toVc.view.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                    leftPart.transform = CGAffineTransform.init(translationX: -halfWidth, y: 0)
                    rightPart.transform = CGAffineTransform.init(translationX: halfWidth, y: 0)
                }, completion: { (true) in
                    fromVc.view.isHidden = false
                    transitionContext.completeTransition(true)
                })
            }
        }
    }
    
    func pop(transitionContext:UIViewControllerContextTransitioning) {
        if let fromVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? OpenDoorShowViewController ,
        let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? OpenDoorViewController {
            let containerView = transitionContext.containerView
            fromVc.view.frame = containerView.bounds
            containerView.addSubview(fromVc.view)
            toVc.view.frame = containerView.bounds
            let halfWidth = containerView.bounds.width / 2
            let leftPartFrame = CGRect.init(x: 0, y: 0, width: halfWidth, height: fromVc.view.bounds.height)
            let rightPartFrame = CGRect.init(x:halfWidth , y: 0, width: halfWidth, height: fromVc.view.bounds.height)
            if let leftPart = toVc.view.resizableSnapshotView(from: leftPartFrame, afterScreenUpdates: true, withCapInsets: .zero) ,
            let rightPart = toVc.view.resizableSnapshotView(from: rightPartFrame, afterScreenUpdates: true, withCapInsets: .zero) {
                let leftInitFrame = CGRect.init(x: -halfWidth, y: 0, width: halfWidth, height: containerView.bounds.height)
                let rightInitFrame = CGRect.init(x: containerView.bounds.width, y: 0, width: halfWidth, height: containerView.bounds.height)
                leftPart.frame = leftInitFrame
                rightPart.frame = rightInitFrame
                containerView.addSubview(leftPart)
                containerView.addSubview(rightPart)
                
                
                containerView.insertSubview(toVc.view, at: 0)
                UIView.animate(withDuration: duration, animations: {
                    toVc.view.transform = CGAffineTransform.init(scaleX: 0.75, y: 0.75)
                    fromVc.view.transform = CGAffineTransform.init(scaleX: 0.75, y: 0.75)
                    leftPart.transform = CGAffineTransform.init(translationX: halfWidth, y: 0)
                    rightPart.transform = CGAffineTransform.init(translationX: -halfWidth, y: 0)
                    
                }, completion: { (true) in
                    toVc.view.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                    leftPart.removeFromSuperview()
                    rightPart.removeFromSuperview()
                    fromVc.view.removeFromSuperview()
                    transitionContext.completeTransition(true)
                })
            }
        }
    }
    
}
