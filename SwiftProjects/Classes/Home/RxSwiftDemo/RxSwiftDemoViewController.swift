//
//  RxSwiftDemoViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/10/10.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxSwiftDemoViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.randomGradientColor(bounds: view.bounds)
        
        
        let textField = UITextField()
        textField.placeholder = "please input ..."
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor.white
        view.addSubview(textField)
        textField.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leftMargin.equalTo(20)
            $0.rightMargin.equalTo(-20)
        }
        
        let resultLabel = UILabel()
        view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(50)
            $0.leftMargin.equalTo(20)
            $0.rightMargin.equalTo(-20)
        }
        
        let button = UIButton(type: .system)
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(100)
            $0.leftMargin.equalTo(20)
            $0.rightMargin.equalTo(-20)
        }
        button.setTitle("Click Me!", for: .normal)
        
        resultLabel.text = "123132123123"
        
        // 数据绑定
        textField.rx.text  // 拿到 text
            .bind(to: resultLabel.rx.text) // 绑定到 resultLabel
            .disposed(by: disposeBag)
        
        // 事件驱动
        resultLabel.rx.observe(String.self, "text").subscribe(onNext: { value in
            print("new text is \(value!)")
        }).disposed(by: disposeBag)
        
        // 禁用按钮
        textField.rx.text.orEmpty.map {
            $0.count >= 6
        }
        .share(replay: 1, scope: .whileConnected)
        .bind(to: button.rx.isEnabled)
        .disposed(by: disposeBag)
        
        
    }
    

}
