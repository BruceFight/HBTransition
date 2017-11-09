//
//  ViewController.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var v = UIView()
    var v1 = UIView()
    var b = UIButton()
    var toListB = UIButton()
    
    fileprivate var collectionView : UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CATransition"
        v1.frame = view.bounds
        v1.backgroundColor = .white
        self.view.addSubview(v1)
        v.frame = view.bounds
        v.backgroundColor = .purple
        self.view.addSubview(v)
        
        b.frame = CGRect.init(x: 0, y: 64, width: 50, height: 50)
        b.setTitle("anim", for: .normal)
        b.setTitleColor(.orange, for: .normal)
        b.addTarget(self, action: #selector(animte), for: .touchUpInside)
        self.view.addSubview(b)
        
        toListB.frame = CGRect.init(x: 0, y: b.frame.maxY + 20, width: 50, height: 50)
        toListB.setTitle("toList", for: .normal)
        toListB.setTitleColor(.blue, for: .normal)
        toListB.addTarget(self, action: #selector(toList), for: .touchUpInside)
        self.view.addSubview(toListB)
    }
    
    func setCollction() -> () {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: 100, height: 100)
    }
    
    @objc func animte() -> () {
        self.v.backgroundColor = .red
        TransitionManager.instance.transition(view: v,
                                              type: CATransitionType.OglFlip.type,
                                              subType: CATransitionSubType.fromRight.type, start: nil, end: nil)
    }
    
    @objc func toList() -> () {
        let listVc = ListTableViewController()
        self.navigationController?.pushViewController(listVc, animated: true)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


