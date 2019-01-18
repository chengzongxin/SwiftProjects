//
//  TestViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/12/26.
//  Copyright © 2018 Jason. All rights reserved.
//

import UIKit

class TestViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView:UITableView!
    
    var count:Int!
    
    var myView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        count = 10;
        
        view.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: view.bounds, andColors: [UIColor.randomFlat,UIColor.randomFlat])

        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = UIColor.orange
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        myView = UIView(frame: CGRect(x: 0, y: 100, width: view.bounds.size.width, height: 50))
        myView.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: myView.bounds, andColors: [UIColor.randomFlat,UIColor.randomFlat])
        tableView.addSubview(myView)
        myView.layer.zPosition = -1  // under the tableview
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.tableFooterView = UIView()
    }

}


extension TestViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.backgroundColor = UIColor.randomFlat
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
}
