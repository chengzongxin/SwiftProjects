//
//  Animation2ViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/12.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class Animation2ViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(self)
        
        view.backgroundColor = UIColor.flatWhite
        
        edgesForExtendedLayout = .init(rawValue: 0)
        
        
        let view1 = ShadowView()
        view1.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        view1.shadowBackgoundColor = UIColor.red
        view.addSubview(view1)
        
        let view2 = ShadowView(frame: CGRect(x: view.frame.size.width - 150, y: 50, width: 100, height: 100))
        view.addSubview(view2)
        
        let button1 = UIButton(type: .system)
        button1.setTitle("Implicitly Anim", for: .normal)
        button1.backgroundColor = UIColor.flatGray
        view.addSubview(button1)
        button1.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(44)
            make.left.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(100)
        }
        
        let button2 = UIButton(type: .system)
        button2.setTitle("Explicitly Anim", for: .normal)
        button2.backgroundColor = UIColor.flatBlue
        view.addSubview(button2)
        button2.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(44)
            make.right.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(100)
        }
        
        
        // MARK: Action
        //按钮点击响应
        // 类里面懒加载 DisposeBag 对象
        button1.rx.tap.bind {
            print("button1 tap")
            
            UIView.animate(withDuration: 1.0, animations: {
                view1.layer.opacity = 0.0
            })
            
            
        }.disposed(by: disposeBag)
        
        button2.rx.tap.bind {
            print("button2 tap")
            
            let fadeAnim = CABasicAnimation(keyPath: "opacity")
            fadeAnim.fromValue = 1
            fadeAnim.toValue = 0
            fadeAnim.duration = 1
            view2.layer.add(fadeAnim, forKey: "opacity")
            // dont forget change the property
            view2.layer.opacity = 0.0
            
        }.disposed(by: disposeBag)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(self)
    }
    
}
