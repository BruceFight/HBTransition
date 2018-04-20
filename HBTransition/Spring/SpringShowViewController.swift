//
//  SpringShowViewController.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class SpringShowViewController: UIViewController ,UIViewControllerTransitioningDelegate {

    fileprivate var iconView = UIImageView()
    open var dismissHandler : (() -> ())?
    fileprivate var manger = DisInteractionManager()
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
        manger.observeGestureFor(vc: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        iconView.frame = view.bounds
        iconView.image = #imageLiteral(resourceName: "flower")
        iconView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(d))
        iconView.addGestureRecognizer(tap)
        view.addSubview(iconView)
    }
    
    @objc func d() -> () {
        dismissHandler?()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SpringShowViewController {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SpringManager.init(pathType: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SpringManager.init(pathType: .dismiss)
    }
    /*
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
     
    }
    */
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return manger.interation ? manger : nil
    }
    /*
     
     - (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
     return _interactiveDismiss.interation ? _interactiveDismiss : nil;
     }
     
     - (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
     XWInteractiveTransition *interactivePresent = [_delegate interactiveTransitionForPresent];
     return interactivePresent.interation ? interactivePresent : nil;
     }*/
}

class DisInteractionManager: UIPercentDrivenInteractiveTransition {
    
    var interation : Bool = false
    fileprivate var pan : UIPanGestureRecognizer?
    weak fileprivate var vc : UIViewController?
    func observeGestureFor(vc:UIViewController) -> () {
        self.vc = vc
        self.pan = UIPanGestureRecognizer.init(target: self, action: #selector(move(pan:)))
        if let pan = self.pan {
            vc.view.addGestureRecognizer(pan)
        }
    }
    
    @objc func move(pan:UIPanGestureRecognizer) -> () {
        var percent : CGFloat = 0
        var y : CGFloat = 0
        if let vc = self.vc {
            y = pan.translation(in: vc.view).y
            percent = y / 300//(vc.view.frame.height)
        }
        switch pan.state {
        case .began:/// 同理dismiss,见OpenDoor
            interation = true
            //self.vc?.navigationController?.popViewController(animated: true)
            self.vc?.dismiss(animated: true, completion: nil)
            break
        case .changed:
            print("❤️ percent: \(percent)")
            self.update(percent)
            break
        case .ended:
            interation = false
            if percent > 0.5 {
                self.finish()
            }else {
                self.cancel()
            }
            break
        default:break
        }
    }
}
