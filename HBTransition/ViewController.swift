//
//  ViewController.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UICollectionViewDelegate ,UICollectionViewDataSource {
    public static let images = [#imageLiteral(resourceName: "bold"),#imageLiteral(resourceName: "eight"),#imageLiteral(resourceName: "five"),#imageLiteral(resourceName: "flower"),#imageLiteral(resourceName: "holk"),#imageLiteral(resourceName: "hope"),#imageLiteral(resourceName: "iron"),#imageLiteral(resourceName: "look"),#imageLiteral(resourceName: "lufei"),#imageLiteral(resourceName: "spider"),#imageLiteral(resourceName: "widow"),#imageLiteral(resourceName: "yeah")]
    public static let abouts = ["淡入淡出","推挤","揭开","覆盖","立方体","吮吸","翻转","波纹","翻页","反翻页","开镜头","关镜头"]
    fileprivate var collectionView : UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CATransition"
        view.backgroundColor = .white
        setCollction()
        let right = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 64))
        right.setTitle("ToList", for: .normal)
        right.setTitleColor(.black, for: .normal)
        right.addTarget(self, action: #selector(toList), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: right)
    }
    
    func setCollction() -> () {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: view.bounds.width * 0.4, height: view.bounds.width * 0.4)
        collectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: layout)
        collectionView?.register(TransitionCollectionViewCell.self, forCellWithReuseIdentifier: "transition_cell")
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .orange
        if let collectionView = collectionView {
            view.addSubview(collectionView)
        }
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

extension ViewController {
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
        if let cell = collectionView.cellForItem(at: indexPath) as? TransitionCollectionViewCell {
            cell.type = TransitionManager.instance.types[indexPath.row]
        }
    }
}
