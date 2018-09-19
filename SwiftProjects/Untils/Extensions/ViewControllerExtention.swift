//
//  ViewControllerFromString.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/19.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

extension UIViewController {
    static func getViewController(VCString: String) -> UIViewController? {
        // get namespace
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        // get 'anyClass' with classname and namespace
        guard let className = NSClassFromString("\(namespace).\(VCString)") as? UIViewController.Type else {
            print("It's not a view controller!")
            return nil
        }
        
        // Instance a ViewController
        let vc = className.init()
        
        return vc
    }
    
    func setBackItem() {
        // 返回图标
        navigationItem.leftBarButtonItem = item(withTarget: self, action: #selector(back), image: "EC_Back", highImage: "EC_Back")
    }
    
    /**
     定义返回按钮样式
     */
    func item(withTarget target: Any?, action: Selector, image imageSTR: String?, highImage: String?) -> UIBarButtonItem? {
        
        let imageView = UIImageView(image: UIImage(named: imageSTR ?? ""))
        
        var imageFrame: CGRect = imageView.frame
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: imageFrame.size.width * 2.0, height: 38.0))
        imageFrame.origin.y = (backView.frame.size.height - imageFrame.size.height) * 0.5
        imageView.frame = imageFrame
        
        backView.addSubview(imageView)
        
        let btn = UIButton(type: .custom)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.frame = backView.bounds
        
        backView.addSubview(btn)
        
        return UIBarButtonItem(customView: backView)
    }

    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
}
