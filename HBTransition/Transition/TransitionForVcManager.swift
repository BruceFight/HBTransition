//
//  TransitionForVcManager.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class TransitionForVcManager: NSObject ,UIViewControllerAnimatedTransitioning {
    open var pathType = MagicPathType.push
    open var delay : TimeInterval = 0
    open var duration : TimeInterval = 0.25
    open var index : Int = 0
    fileprivate var fromVc = UIViewController()
    fileprivate var toVc = UIViewController()
    fileprivate var tempView = UIView()
    fileprivate var transitionContext : UIViewControllerContextTransitioning?
    fileprivate var containerView = UIView()
    
    init(pathType:MagicPathType ,index:Int) {
        self.pathType = pathType
        self.index = index
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
        self.transitionContext = transitionContext
        if let fromVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? TransitionViewController,
        let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? TransitionShowViewController {
            containerView = transitionContext.containerView
            guard let tempView = fromVc.view.snapshotView(afterScreenUpdates: false) else { return }
            self.tempView = tempView
            tempView.frame = containerView.bounds
            fromVc.view.isHidden = true
            toVc.view.frame = containerView.bounds
            containerView.addSubview(toVc.view)
            containerView.addSubview(tempView)
            containerView.bringSubview(toFront: toVc.view)
            TransitionManager.instance.transition(view: containerView,
                                                  type: TransitionManager.instance.types[index].type,
                                                  subType: CATransitionSubType.fromRight.type,
                                                  start: nil,
                                                  end: {[weak self](anim, flag)in
                if let transitionContext = self?.transitionContext {  transitionContext.completeTransition(true)
                }
            })
        }
    }
    
    func pop(transitionContext:UIViewControllerContextTransitioning) -> () {
        self.transitionContext = transitionContext
        if let fromVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? TransitionShowViewController ,
        let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? TransitionViewController {
            self.fromVc = fromVc
            self.toVc = toVc
            containerView = transitionContext.containerView
            let count = containerView.subviews.count
            if count - 2 < 0 { return }
            self.tempView = containerView.subviews[count - 2]
            containerView.insertSubview(toVc.view, at: 0)
            containerView.bringSubview(toFront: tempView)
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            if transitionContext.transitionWasCancelled {
                self.tempView.isHidden = true
            }else {
                self.fromVc.view.alpha = 0
                self.toVc.view.isHidden = false
                self.tempView.removeFromSuperview()
            }
            TransitionManager.instance.transition(view: containerView,
                                                  type: TransitionManager.instance.types[index].type,
                                                  subType: CATransitionSubType.fromLeft.type,
                                                  start: nil,
                                                  end: nil)
        }
    }
}
