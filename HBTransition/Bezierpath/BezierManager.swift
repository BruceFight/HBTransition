//
//  BezierManager.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class BezierManager: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    
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
        if let fromVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? UINavigationController ,
        let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) {
            guard let real = fromVc.viewControllers.last else { return }
            guard let realFromVc = real as? BezierViewController else { return }
            let containerView = transitionContext.containerView
            containerView.addSubview(toVc.view)
            let startCycle = UIBezierPath.init(ovalIn: realFromVc.redBtn.frame)
            let x = max(realFromVc.redBtn.frame.origin.x, fromVc.view.bounds.width - realFromVc.redBtn.frame.origin.x)
            let y = max(realFromVc.redBtn.frame.origin.y, fromVc.view.bounds.width - realFromVc.redBtn.frame.origin.y)
            let radius = sqrtf(Float(pow(x, 2) + pow(y, 2)))
            let endCycle = UIBezierPath.init(arcCenter: containerView.center, radius: CGFloat(radius), startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
            
            let maskLayer = CAShapeLayer()
            maskLayer.path = endCycle.cgPath
            toVc.view.layer.mask = maskLayer
            
            let maskAnimation = CABasicAnimation.init(keyPath: "path")
            maskAnimation.fromValue = startCycle.cgPath
            maskAnimation.toValue = endCycle.cgPath
            maskAnimation.duration = duration
            maskAnimation.delegate = self
            maskAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            maskAnimation.setValue(transitionContext, forKey: "transitionContext")
            maskLayer.add(maskAnimation, forKey: "maskAnimation")
        }
    }
    
    func dismiss(transitionContext:UIViewControllerContextTransitioning) {
        if let fromVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) ,
        let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? UINavigationController {
            guard let real = toVc.viewControllers.last else { return }
            guard let realToVc = real as? BezierViewController else { return }
            let containerView = transitionContext.containerView
            
            let radius = sqrtf(powf(Float(containerView.bounds.width), 2) + powf(Float(containerView.bounds.height), 2)) / 2
            let startCycle = UIBezierPath.init(arcCenter: containerView.center, radius: CGFloat(radius), startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
            let endCycle = UIBezierPath.init(ovalIn: realToVc.redBtn.frame)
            
            let maskLayer = CAShapeLayer()
            maskLayer.path = endCycle.cgPath
            fromVc.view.layer.mask = maskLayer
            
            let maskAnimation = CABasicAnimation.init(keyPath: "path")
            maskAnimation.fromValue = startCycle.cgPath
            maskAnimation.toValue = endCycle.cgPath
            maskAnimation.duration = duration
            maskAnimation.delegate = self
            maskAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            maskAnimation.setValue(transitionContext, forKey: "transitionContext")
            maskLayer.add(maskAnimation, forKey: "maskAnimation")
        }
    }
    
}

extension BezierManager {
    
    func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        switch self.pathType {
        case .present:
            if let transitionContext = anim.value(forKey: "transitionContext") as?UIViewControllerContextTransitioning {
                transitionContext.completeTransition(true)
            }
            break
        case .dismiss:
            if let transitionContext = anim.value(forKey: "transitionContext") as?UIViewControllerContextTransitioning {
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                if transitionContext.transitionWasCancelled {}
                transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)?.view.layer.mask = nil
            }
            break
        }
    }
    
}
