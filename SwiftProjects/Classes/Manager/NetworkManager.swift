//
//  NetworkManager.swift
//  SwiftProjects
//
//  Created by Jason on 2018/7/24.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD
import Toast

struct NetworkManager {
    
    static let errorMessage = "网络异常,请检查网络"
    
    static func GET(URLString: String, parameters: [String:Any]?, showHUD: Bool = true, success:((NSObject?) -> Void)?, failure: ((NSError) -> Void)?) {
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = 10
        
        if showHUD {
            SVProgressHUD.show()
        }
        
        manager.get(URLString, parameters: parameters, progress: { (progress) in
            SVProgressHUD.dismiss()
            print(progress)
        }, success: { (task, responseObject) in
            SVProgressHUD.dismiss()
            print(responseObject ?? "")
            success?(responseObject as? NSObject)
        }) { (task, error) in
            SVProgressHUD.dismiss()
            print(error.localizedDescription)
            failure?(error as NSError)
        }
    }
    
    static func POST(URLString: String, parameters: [String:AnyObject]?, showHUD: Bool = true, success:((NSObject?) -> Void)?, failure: ((NSError) -> Void)?) {
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = 10
        
        if showHUD {
            SVProgressHUD.show()
        }
        
        manager.post(URLString, parameters: parameters, progress: { (progress) in
            SVProgressHUD.dismiss()
            print(progress)
        }, success: { (task, responseObject) in
            SVProgressHUD.dismiss()
            print(responseObject ?? "")
            success?(responseObject as? NSObject)
        }) { (task, error) in
            SVProgressHUD.dismiss()
            print(error.localizedDescription)
            failure?(error as NSError)
        }
    }
}
