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
    static let ESCAPE = "\u{001b}["
    
    static let RESET_FG = ESCAPE + "fg;" // Clear any foreground color
    static let RESET_BG = ESCAPE + "bg;" // Clear any background color
    static let RESET = ESCAPE + ";"   // Clear any foreground or background color
    static let codeColor = "fg255,0,0"
    typealias StatusCode = Int
    
    static func GET(URLString: String, parameters: [String:Any]?, showHUD: Bool = true, success:((AnyObject?) -> Void)?, failure: ((NSError) -> Void)?) {
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = 10
        
        if showHUD {
            SVProgressHUD.showInfo(withStatus: "Loading...")
        }
        
        manager.get(URLString, parameters: parameters, progress: { (progress) in
            SVProgressHUD.dismiss()
            print(progress)
        }, success: { (task, responseObject) in
            SVProgressHUD.dismiss()
//            Logger.info(responseObject)
//            print(responseObject ?? "")
            let statusCode = 200
            log.debug("\(ESCAPE)\(codeColor);\(statusCode)\(RESET) \(ESCAPE)fg53,255,206;\("GET")\(RESET) \(ESCAPE)fg69,69,69;\(URLString)\("target.path") \(parameters ?? [:])\(RESET) \n\(ESCAPE)fg29,29,29;\(String(describing: responseObject))\(RESET)")
            
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
            let statusCode = 200
            log.debug("\(ESCAPE)\(codeColor);\(statusCode)\(RESET) \(ESCAPE)fg53,255,206;\("GET")\(RESET) \(ESCAPE)fg69,69,69;\(URLString)\("target.path") \(parameters ?? [:])\(RESET) \n\(ESCAPE)fg29,29,29;\(String(describing: responseObject))\(RESET)")
            success?(responseObject as? NSObject)
        }) { (task, error) in
            SVProgressHUD.dismiss()
            print(error.localizedDescription)
            failure?(error as NSError)
        }
    }
}
