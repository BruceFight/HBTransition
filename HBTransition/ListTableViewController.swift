//
//  ListTableViewController.swift
//  HBTransition
//
//  Created by jianghongbao on 2017/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    var params = ["Transition实用","神奇移动","弹性","bezier扩散","正门大开"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "list_cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.params.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "list_cell", for: indexPath)
        cell.textLabel?.text = self.params[indexPath.row]
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc : UIViewController?
        switch indexPath.row {
        case 0:
            vc = TransitionViewController()
            break
        case 1:
            vc = SpringViewController()
            break
        case 2:
            vc = MagicViewController()
            break
        case 3:
            vc = BezierViewController()
            break
        case 4:
            vc = OpenDoorViewController()
            break
        default:break
        }
        if let vc = vc {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
