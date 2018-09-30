//
//  CenterViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/7/24.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class CenterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: view.bounds, andColors: [UIColor.randomFlat,UIColor.randomFlat])
        
        log.verbose("一条verbose级别消息：程序执行时最详细的信息。")
        log.debug("一条debug级别消息：用于代码调试。")
        log.info("一条info级别消息：常用与用户在console.app中查看。")
        log.warning("一条warning级别消息：警告消息，表示一个可能的错误。")
        log.error("一条error级别消息：表示产生了一个可恢复的错误，用于告知发生了什么事情。")
        log.severe("一条severe error级别消息：表示产生了一个严重错误。程序可能很快会奔溃。")
        
        NetworkLog.out(statusCode: 200, target: (baseURL: NSURL(string: "http://swift.gg")!, path: "/v5", method: "GET", parameters: ["article": 1 as AnyObject]), json: ["title":"结构体中的 Lazy 属性探究", "author":"Ole Begemann", "translator":"pmst","content":"666666"] as AnyObject)
        NetworkLog.out(statusCode: 404, target: (baseURL: NSURL(string: "http://swift.gg")!, path: "/v5", method: "GET", parameters: ["article": 0 as AnyObject]), json: ["error":"nonexistence"] as AnyObject)
    }

}
