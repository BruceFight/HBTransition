//
//  TransitionManager.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

/** CATransitionType
 * decide the animation of UIView.layer
 */
enum CATransitionType {
    case Fade                       //淡入淡出
    case Push                       //推挤
    case Reveal                     //揭开
    case MoveIn                     //覆盖
    case Cube                       //立方体
    case SuckEffect                 //吮吸
    case OglFlip                    //翻转
    case RippleEffect               //波纹
    case PageCurl                   //翻页
    case PageUnCurl                 //反翻页
    case CameraIrisHollowOpen       //开镜头
    case CameraIrisHollowClose      //关镜头
    
    var type : String {
        switch self {
        case .Fade:
            return kCATransitionFade
        case .Push:
            return kCATransitionPush
        case .Reveal:
            return kCATransitionReveal
        case .MoveIn:
            return kCATransitionMoveIn
        case .Cube:
            return "cube"
        case .SuckEffect:
            return "suckEffect"
        case .OglFlip:
            return "oglFlip"
        case .RippleEffect:
            return "rippleEffect"
        case .PageCurl:
            return "pageCurl"
        case .PageUnCurl:
            return "pageUnCurl"
        case .CameraIrisHollowOpen:
            return "cameraIrisHollowOpen"
        case .CameraIrisHollowClose:
            return "cameraIrisHollowClose"
        }
    }
    
}
/** CATransitionSubType
 * decide the direction of animation
 */
enum CATransitionSubType {
    case fromLeft   //从左边开始
    case fromRight  //从右边开始
    case fromTop    //从上边开始
    case fromBottom //从下边开始
    
    var type : String {
        switch self {
        case .fromLeft:
            return kCATransitionFromLeft
        case .fromRight:
            return kCATransitionFromRight
        case .fromTop:
            return kCATransitionFromTop
        case .fromBottom:
            return kCATransitionFromBottom
        }
    }
}

class TransitionManager: NSObject ,CAAnimationDelegate {
    
    public static let instance = TransitionManager()
    
    internal override init() {
        
    }
    typealias Handler = ((_ anim: CAAnimation ,_ flag: Bool) -> ())?
    open var startHandler : Handler?
    open var endHandler : Handler?
    
    //MARK: - Implement
    func transition(view:UIView ,
                    type:String ,
                    subType:String? ,
                    duration:TimeInterval = 0.6,
                    start:Handler,
                    end:Handler) -> () {
        startHandler = start
        endHandler = end
        let animation = CATransition()
        animation.delegate = self
        animation.duration = duration
        animation.type = type
        if let subType = subType {
            animation.subtype = subType
        }
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        view.layer.add(animation, forKey: "animation")
    }
    
}

extension TransitionManager {
    func animationDidStart(_ anim: CAAnimation) {
        if let start = startHandler {
            start?(anim,false)
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let end = endHandler {
            end?(anim,flag)
        }
    }
}
