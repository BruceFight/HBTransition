//
//  CardManager.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/10.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class CardManager: NSObject ,UIViewControllerAnimatedTransitioning {
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
        if let fromVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? CardViewController ,
        let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? CardShowViewController {
            let containerView = transitionContext.containerView
            toVc.view.frame = CGRect.init(x: 0, y: containerView.bounds.height, width: containerView.bounds.width, height: containerView.bounds.height)
            containerView.insertSubview(toVc.view, aboveSubview: fromVc.view)
            
            UIView.animateKeyframes(withDuration: duration, delay: delay, options: UIViewKeyframeAnimationOptions.calculationModeCubic, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4, animations: {
                    fromVc.view.layer.transform = self.firstTransform()
                    fromVc.view.alpha = 0.6
                })
                UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.4, animations: {
                    fromVc.view.layer.transform = self.secondTransform(v: fromVc.view)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2, animations: {
                    toVc.view.frame = containerView.bounds
                })
            }, completion: { (true) in
                transitionContext.completeTransition(true)
            })
        }
    }
    
    func pop(transitionContext:UIViewControllerContextTransitioning) {
        if let fromVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? CardShowViewController ,
        let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? CardViewController {
            let containerView = transitionContext.containerView
            let t3d = CATransform3DIdentity
            toVc.view.layer.transform = CATransform3DScale(t3d, 0.6, 0.6, 1)
            toVc.view.alpha = 0.6
            containerView.insertSubview(toVc.view, aboveSubview: fromVc.view)
            UIView.animateKeyframes(withDuration: duration, delay: delay, options: UIViewKeyframeAnimationOptions.calculationModeCubic, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
                    fromVc.view.frame = CGRect.init(x: 0, y: containerView.bounds.height, width: containerView.bounds.width, height: containerView.bounds.height)
                })
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4, animations: {
                    toVc.view.layer.transform = self.firstTransform()
                    toVc.view.alpha = 1.0
                })
                UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.4, animations: {
                    toVc.view.layer.transform = CATransform3DIdentity;
                })
            }, completion: { (true) in
                transitionContext.completeTransition(true)
            })
        }
    }

    func firstTransform() -> CATransform3D {
        var t3d = CATransform3DIdentity
        t3d.m34 = 1.0 / -900
        t3d = CATransform3DScale(t3d, 0.85, 0.85, 1)
        t3d = CATransform3DRotate(t3d, 30.0 * CGFloat.pi / 180.0, 1, 0, 0)
        return t3d
    }
    
    func secondTransform(v:UIView) -> CATransform3D {
        var t3d = CATransform3DIdentity
        t3d.m34 = self.firstTransform().m34
        t3d = CATransform3DTranslate(t3d, 0, v.bounds.height * -0.08, 0)
        t3d = CATransform3DScale(t3d, 0.8, 0.8, 1)
        return t3d
    }
}
