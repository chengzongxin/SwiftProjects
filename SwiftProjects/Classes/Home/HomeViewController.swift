//
//  HomeViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/7/20.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let urlString = "https://api.douban.com/v2/book/search"
    var tag = "Swift"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: view.bounds, andColors: [UIColor.randomFlat,UIColor.randomFlat])
        
        NetworkManager.GET(URLString: urlString, parameters: ["tag" : tag, "start" : 0, "count" : 10], success: { (responseObject) in
            print(responseObject ?? "")
        }) { (error) in
            print(error)
        }
    }


}
