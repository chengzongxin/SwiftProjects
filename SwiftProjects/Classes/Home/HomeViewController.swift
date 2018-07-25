//
//  HomeViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/7/20.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

let cellIdentifier = "UITableViewCell"

class HomeViewController: UIViewController {
    
    var dataSource = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.append("图书展示")
        
        view.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: view.bounds, andColors: [UIColor.randomFlat,UIColor.randomFlat])
        
        tableView.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: view.bounds, andColors: [UIColor.randomFlat,UIColor.randomFlat])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        
        tableView.tableFooterView = UIView()
    }
    
    
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = dataSource[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.performSegue(withIdentifier: "BookTableViewController", sender: nil)
    }
}


