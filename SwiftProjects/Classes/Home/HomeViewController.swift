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
    var dataSource = [(title:String ,viewController:String, isXib:Bool)]()
    
    @IBOutlet weak var tableView: UITableView!
    // 1. Create animator object
    var animator = MagicMoveAnimator()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.append((title: "图书展示", viewController:"BookTableViewController", isXib:true))
        dataSource.append((title: "自定义View", viewController:"CustomViewController", isXib:true))
        dataSource.append((title: "豆瓣Top250(StackView Achieve)", viewController:"MovieTableViewController", isXib:true))
        dataSource.append((title: "图表框架Charts", viewController:"ChartsViewController", isXib:true))
        dataSource.append((title: "协议练习", viewController:"ProtocolPracticeViewController", isXib:false))
        dataSource.append((title: "短视频(七牛)", viewController:"ShortVideoViewController", isXib:true))

        view.backgroundColor      = UIColor(gradientStyle: .topToBottom, withFrame: view.bounds, andColors: [UIColor.randomFlat,UIColor.randomFlat])

        tableView.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: view.bounds, andColors: [UIColor.randomFlat,UIColor.randomFlat])

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

        tableView.tableFooterView = UIView()
        // 2.1 Set navigation delegate
        navigationController?.delegate = animator
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
        
        let isXib = dataSource[indexPath.row].isXib
        let vcName = dataSource[indexPath.row].viewController
        
        if isXib {
            // 直接取出identifier perform
            self.performSegue(withIdentifier: vcName, sender: nil)
        }else{
            // navigationPush
            let vc = UIViewController.getViewController(VCString: vcName)!
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
            
            // 2.2 Set present modal delegate
//            vc.transitioningDelegate = animator
//            present(vc, animated: true, completion: nil)
        }
        
    }
}
