//
//  BezierViewController.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class BezierViewController: PulicViewController {

    open var redBtn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bezier"
        view.backgroundColor = .red
        iconView.frame = view.bounds
        iconView.image = #imageLiteral(resourceName: "five")
        iconView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(p))
        iconView.addGestureRecognizer(tap)
        view.addSubview(iconView)
        
        redBtn.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
        redBtn.center = view.center
        redBtn.addTarget(self, action: #selector(p), for: .touchUpInside)
        redBtn.backgroundColor = .red
        redBtn.layer.cornerRadius = 25
        view.addSubview(redBtn)
        // Do any additional setup after loading the view.
    }
    
    @objc override func p() -> () {
        let showVc = BezierShowViewController()
        showVc.dismissHandler = {[weak self] in
            self?.navigationController?.dismiss(animated: true, completion: nil)
        }
        self.navigationController?.present(showVc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
