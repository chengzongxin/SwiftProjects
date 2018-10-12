//
//  FourViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/7/20.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FourViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSelf()
        
        addView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        
        // 导航栏透明
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isTranslucent = false
    }

    func initSelf() {
        
        view.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: view.bounds, andColors: [UIColor.randomFlat,UIColor.randomFlat])
        
        navigationController?.navigationBar.isHidden = false
        // 4、设置导航栏半透明
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.subviews[0].subviews[1].alpha = 0
            
            navigationController?.navigationBar.subviews[0].subviews[0].isHidden = true
        } else {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
        }
        
        // 隐藏导航栏下划线
//        (navigationController?.navigationBar.subviews as NSArray?)?.enumerateObjects({ obj, idx, stop in
//
//            if (obj is NSClassFromString("_UIBarBackground")) || (obj is NSClassFromString("_UINavigationBarBackground")) {
//
//                obj.clipsToBounds = true
//            }
//        })
        
//        let statuesH: CGFloat = UIApplication.shared.statusBarFrame.size.height + 44
    }
    
    func addView() {
        let image = UIImage(named: "mybg")!
        let topBg = UIImageView(image: image)
        view.addSubview(topBg)
        topBg.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(image.size.height)
        }
        
        let avatar = UIImageView(image: UIImage(named: "avatar_default"))
        topBg.addSubview(avatar)
        avatar.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        let button = UIButton(type: .system)
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(44)
            $0.width.equalTo(300)
        }
        button.setTitle("Push", for: .normal)
        button.rx.tap.bind {
            self.navigationController?.pushViewController(UIViewController(), animated: true)
            }.disposed(by: disposeBag)
    }

}
