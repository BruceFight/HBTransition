//
//  MagicViewController.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class MagicViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource ,UINavigationControllerDelegate {

    fileprivate var tableView = UITableView()
    fileprivate var images = ["bold","hope","look","yeah","five","eight"]
    open var selectedMagicCell = MagicTableViewCell()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "神奇移动"
        let naviHeight = self.navigationController?.navigationBar.bounds.height ?? 0
        tableView.frame = CGRect.init(x: 0, y: naviHeight, width: view.bounds.width, height: view.bounds.height - naviHeight)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MagicViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "magic_cell") as? MagicTableViewCell
        if cell == nil {
            cell = MagicTableViewCell.init(style: .default, reuseIdentifier: "magic_cell")
        }
        if let image = UIImage.init(named: self.images[indexPath.row]) {
            cell?.iconView.image = image
        }
        return cell ?? MagicTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let magicCell = tableView.cellForRow(at: indexPath) as? MagicTableViewCell {
            self.selectedMagicCell = magicCell
        }
        let showVc = MagicShowViewController()
        if let image = UIImage.init(named: self.images[indexPath.row]) {
            showVc.icon = image
        }
        self.navigationController?.delegate = showVc
        self.navigationController?.pushViewController(showVc, animated: true)
    }
}
