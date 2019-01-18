//
//  ThirdViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/7/20.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ThirdViewController: UIViewController, UITextFieldDelegate {
    
    var button: UIButton!
    var xtextField: UITextField!
    var ytextField: UITextField!
    var textField: UITextField!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: view.bounds, andColors: [UIColor.randomFlat,UIColor.randomFlat])
        
        button = UIButton(type: .system)
        button.backgroundColor = UIColor.orange
        button.setTitle("Button", for: .normal)
        view.addSubview(button)
        
        textField = UITextField()
        textField.placeholder = "Input button width/height"
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.returnKeyType = .send
        textField.delegate = self
        view.addSubview(textField)
        
        xtextField = UITextField()
        xtextField.placeholder = "Input button x"
        xtextField.textAlignment = .center
        xtextField.backgroundColor = UIColor.white
        xtextField.returnKeyType = .send
        xtextField.delegate = self
        view.addSubview(xtextField)
        
        ytextField = UITextField()
        ytextField.placeholder = "Input button y"
        ytextField.textAlignment = .center
        ytextField.backgroundColor = UIColor.white
        ytextField.returnKeyType = .send
        ytextField.delegate = self
        view.addSubview(ytextField)
        
        // 数据绑定
//        textField.rx.text.orEmpty.asObservable()
//            .subscribe(onNext: {
//                print("您输入的是：\($0)")
//                self.updateViewConstraints()
//            })
//            .disposed(by: disposeBag)
        
        /* constrant */
        button.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        xtextField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().inset(150)
            make.leftMargin.equalTo(20)
            make.width.equalTo(100)
        }
        
        ytextField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().inset(150)
            make.left.equalTo(xtextField.snp_rightMargin).offset(20)
            make.width.equalTo(100)
        }
        
        textField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().inset(150)
            make.left.equalTo(ytextField.snp_rightMargin).offset(20)
            make.width.equalTo(100)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateViewConstraints()
        return true
    }
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        let x = Int(xtextField.text ?? "50") ?? 50
        let y = Int(ytextField.text ?? "50") ?? 50
        let height = Int(textField.text ?? "50") ?? 50
        button.snp.remakeConstraints { (make) in
            make.left.equalTo(x)
            make.top.equalTo(y)
            make.size.equalTo(CGSize(width: height, height: height))
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 9, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (complete) in
            
        };
    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        updateViewConstraints()
    }

}
