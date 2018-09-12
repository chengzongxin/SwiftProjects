//
//  BaseViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/5.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: - Properties
    // MyView
    lazy var myView: UIView = {
        let view = ShadowView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.shadowBackgoundColor = UIColor.flatOrange
        view.center = self.view.center
        return view
    }()
    // StartButton
    lazy var startButton: UIButton = {
        let button = ShadowButton(type: .system)
        button.setTitle("Start Animation", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        button.shadowBackgoundColor = UIColor.randomGradientColor(bounds: button.bounds)
        button.center = CGPoint(x: self.view.center.x, y: self.view.frame.size.height - 200)
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return button
    }()

    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Animation Base ViewController"
        
        edgesForExtendedLayout = .init(rawValue: 0) // Set content view following the navbar
        
        view.backgroundColor = UIColor.white

        view.addSubview(myView)
        
        view.addSubview(startButton)
    }
    
    // MARK: - Private Method
    @objc public func buttonClick() {
        print(self)
    }
}
