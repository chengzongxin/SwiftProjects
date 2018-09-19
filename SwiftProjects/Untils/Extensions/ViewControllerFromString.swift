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
}
