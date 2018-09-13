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
        
        view.backgroundColor = UIColor.randomGradientColor(bounds: view.bounds)
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
}
