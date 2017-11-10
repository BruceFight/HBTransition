//
//  TransitionViewController.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class TransitionViewController: UIViewController ,UINavigationControllerDelegate ,UICollectionViewDelegate ,UICollectionViewDataSource {

    fileprivate var iconView = UIImageView()
    fileprivate var collectionView : UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transition实用"
        view.backgroundColor = .red
        iconView.frame = view.bounds
        iconView.image = #imageLiteral(resourceName: "look")
        iconView.isUserInteractionEnabled = false
        view.addSubview(iconView)
        setCollction()
    }
    
    func setCollction() -> () {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: view.bounds.width * 0.4, height: view.bounds.width * 0.4)
        collectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: layout)
        collectionView?.register(TransitionCollectionViewCell.self, forCellWithReuseIdentifier: "transition_cell")
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .clear
        if let collectionView = collectionView {
            view.addSubview(collectionView)
        }
    }
    
    func p(index:Int) -> () {
        let showVc = TransitionShowViewController()
        showVc.index = index
        self.navigationController?.delegate = showVc
        self.navigationController?.pushViewController(showVc, animated: true)
    }
    
    deinit {
        print("Deinit -> \(self)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TransitionViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ViewController.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "transition_cell", for: indexPath) as? TransitionCollectionViewCell {
            cell.image = ViewController.images[indexPath.row]
            cell.about = ViewController.abouts[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.p(index: indexPath.row)
    }
}

