//
//  AppDelegate.swift
//  SwiftProjects
//
//  Created by Jason on 2018/7/20.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import SwiftyBeaver
let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = MainTabBarController()
        
        window?.makeKeyAndVisible()
        // Config ProgressHud
        configProgressHub()
        
        
        
        print("Finish Launch!")
        
        return true
    }

}

