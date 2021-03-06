//
//  ProtocolPracticeViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/19.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProtocolPracticeViewController: UIViewController {

    open var demo: ProtocolPractice?
    
    var label1: UILabel!
    
    var label2: UILabel!
    
    var button: UIButton!
    
    var bag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.randomGradientColor(bounds: view.bounds)
        
        if #available(iOS 11.0, *) {
            view.backgroundColor = UIColor.init(named: "Tiffany Blue")
        } else {
            // Fallback on earlier versions
        }
        
        setBackItem()
        
        initView()
        
        demo = ProtocolInstance()
        
        label1.text = demo?.test
        
        label2.text = demo?.practice()
    }
}

extension ProtocolPracticeViewController {
    
    func initView() {
        label1 = UILabel()
        self.view.addSubview(label1)
        label1.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        label2 = UILabel()
        self.view.addSubview(label2)
        label2.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(label1.snp.bottom).offset(30)
        }
        
        button = UIButton(type: .system)
        button.setTitle("dismiss", for: .normal)
        button.rx.tap.bind{
            self.dismiss(animated: true, completion: nil)
        }.disposed(by: bag)
        self.view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(label2.snp.bottom).offset(30)
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        label2.text = demo?.practice()
    }
}
