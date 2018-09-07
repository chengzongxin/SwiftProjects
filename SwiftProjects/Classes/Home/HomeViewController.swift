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
    // 元组数组->(Title,ViewController)
    var dataSource = [(title:String ,viewController:String)]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.append((title:"图书展示" , viewController:"BookTableViewController"))
        dataSource.append((title:"自定义View", viewController: "CustomViewController"))
        dataSource.append((title:"豆瓣Top250(StackView Achieve)", viewController: "MovieTableViewController"))
        
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
        
        cell.textLabel?.text = dataSource[indexPath.row].title
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 直接取出identifier perform
        self.performSegue(withIdentifier: dataSource[indexPath.row].viewController, sender: nil)
        
    }
}


