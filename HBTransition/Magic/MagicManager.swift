//
//  MagicManager.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

enum MagicPathType {
    case push
    case pop
}
class MagicManager: NSObject ,UIViewControllerAnimatedTransitioning {
    open var pathType = MagicPathType.push
    open var delay : TimeInterval = 0
    open var duration : TimeInterval = 0.6
    
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
    
    func push(transitionContext:UIViewControllerContextTransitioning) -> () {
        if let fromVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? MagicViewController ,
            let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? MagicShowViewController {
            let containerView = transitionContext.containerView
            guard let tempIconView = fromVc.selectedMagicCell.iconView.snapshotView(afterScreenUpdates: false) else { return }
            tempIconView.frame = fromVc.selectedMagicCell.iconView.convert(fromVc.selectedMagicCell.iconView.bounds, to: containerView)
            fromVc.selectedMagicCell.iconView.isHidden = true
            toVc.view.alpha = 0
            toVc.iconView.isHidden = true
            
            containerView.addSubview(toVc.view)
            containerView.addSubview(tempIconView)
            // usingSpringWithDamping ,值越小,效果越明显
            // initialSpringVelocity ,值越大,效果越明显
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.35, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                tempIconView.frame = toVc.iconView.convert(toVc.iconView.bounds, to: containerView)
                toVc.view.alpha = 1
            }, completion: { (true) in
                tempIconView.isHidden = true
                toVc.iconView.isHidden = false
                transitionContext.completeTransition(true)
            })
        }
    }
    
    func pop(transitionContext:UIViewControllerContextTransitioning) -> () {
        if let fromVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? MagicShowViewController ,
        let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? MagicViewController {
            let containerView = transitionContext.containerView
            guard let tempIconView = containerView.subviews.last else { return }
            toVc.selectedMagicCell.iconView.isHidden = true
            fromVc.iconView.isHidden = true
            tempIconView.isHidden = false
            containerView.insertSubview(toVc.view, at: 0)
            UIView.animate(withDuration: duration, animations: {
                tempIconView.frame = toVc.selectedMagicCell.iconView.convert(toVc.selectedMagicCell.iconView.bounds, to: containerView)
                fromVc.view.alpha = 0
            }, completion: { (true) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                if transitionContext.transitionWasCancelled {
                    tempIconView.isHidden = true
                    fromVc.iconView.isHidden = false
                }else {
                    toVc.selectedMagicCell.iconView.isHidden = false
                    tempIconView.removeFromSuperview()
                }
            })
        }
    }
}
