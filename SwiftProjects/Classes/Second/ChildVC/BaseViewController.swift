//
//  BaseViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/5.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self)
        
        edgesForExtendedLayout = .init(rawValue: 0) // Set content view following the navbar
        
//        view.backgroundColor = UIColor.randomGradientColor(bounds: view.bounds)
        view.backgroundColor = UIColor.white
        
        // 返回图标
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "EC_Back"), style: .done, target: self, action: #selector(back))
        // 返回图标y
        navigationController?.navigationBar.tintColor = UIColor.flatOrange
    }
    
    @objc internal override func back() {
        navigationController?.popViewController(animated: true)
    }
}
