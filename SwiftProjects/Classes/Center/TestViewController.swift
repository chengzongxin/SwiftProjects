//
//  TestViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/12/26.
//  Copyright © 2018 Jason. All rights reserved.
//

import UIKit
import SwiftyBeaver

class TestViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView:UITableView!
    
    var count:Int!
    
    var myView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        count = 10;
        
        view.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: view.bounds, andColors: [UIColor.randomFlat,UIColor.randomFlat])

        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = UIColor.orange
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        myView = UIView(frame: CGRect(x: 0, y: 100, width: view.bounds.size.width, height: 50))
        myView.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: myView.bounds, andColors: [UIColor.randomFlat,UIColor.randomFlat])
        tableView.addSubview(myView)
        myView.layer.zPosition = -1  // under the tableview
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.tableFooterView = UIView()
        
        
        
        
        // Xcode控制台日志
        let console = ConsoleDestination()
        // 默认swiftybeaver.log文件日志
        let file = FileDestination()
        // cloud平台配置
        let cloud = SBPlatformDestination(appID: "foo", appSecret: "bar", encryptionKey: "123")
        
        
        // 使用自定义格式输出短时间、日志级别、信息
        // console.format = "$DHH:mm:ss$d $L $M"
        // 或者使用 console.format = "$J" 输出JSON格式
        
        //添加配置到SwiftyBeaver
        log.addDestination(console)
        log.addDestination(file)
        log.addDestination(cloud)
        
        //日志具有不同重要性
        log.verbose("not so important")                 // 优先级 1, VERBOSE   紫色
        log.debug("something to debug")                 // 优先级 2, DEBUG     绿色
        log.info("a nice information")                  // 优先级 3, INFO      蓝色
        log.warning("oh no, that won’t be good")        // 优先级 4, WARNING   黄色
        log.error("ouch, an error did occur!")          // 优先级 5, ERROR     红色
        
        //支持类型: 字符串,数字,日期,等等
        log.verbose(123)
        log.info(-123.45678)
        log.warning(Date())
        log.error(["I", "like", "logs!"])
        log.error(["name": "Mr Beaver", "address": "7 Beaver Lodge"])
        
        NetworkLog.out(statusCode: 200, target: (baseURL: NSURL(string: "http://swift.gg")!, path: "/v5", method: "GET", parameters: ["article": 1 as AnyObject]), json: ["title":"结构体中的 Lazy 属性探究", "author":"Ole Begemann", "translator":"pmst","content":"666666"] as AnyObject)
        NetworkLog.out(statusCode: 404, target: (baseURL: NSURL(string: "http://swift.gg")!, path: "/v5", method: "GET", parameters: ["article": 0 as AnyObject]), json: ["error":"nonexistence"] as AnyObject)
        
        
        let label = UILabel()
        label.text = "Touch me push to text VC"
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
    }

}


extension TestViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.backgroundColor = UIColor.randomFlat
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
}
