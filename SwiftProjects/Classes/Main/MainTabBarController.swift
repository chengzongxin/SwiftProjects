//
//  MainTabBarController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/7/20.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    var selectItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSelf()
        
        addCenterButton()
        
        addChildVC()
        
        // Select Second ViewController
//        self.selectedIndex = 1
    }
    
    //MARK: Setup UI
    func initSelf() {
        // Setup TabBar Item Appearance
        let attr: [NSAttributedStringKey : Any]  = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12),
                                                    NSAttributedStringKey.foregroundColor : UIColor.init(hexString: "999999") ?? UIColor()]
        let selectedAttr: [NSAttributedStringKey : Any]  = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12),
                                                            NSAttributedStringKey.foregroundColor : UIColor.init(hexString: "FFA701") ?? UIColor()]
        
        let item = UITabBarItem.appearance()
        item.setTitleTextAttributes(attr, for: .normal)
        item.setTitleTextAttributes(selectedAttr, for: .selected)
        self.delegate = self
    }
    
    // Add Child VC
    func addChildVC() {
        let home   = UIStoryboard.init(name: "Home", bundle: nil).instantiateInitialViewController()!
        let second = UIStoryboard.init(name: "Second", bundle: nil).instantiateInitialViewController()!
        let center = UIStoryboard.init(name: "Center", bundle: nil).instantiateInitialViewController()!
        let third  = UIStoryboard.init(name: "Third", bundle: nil).instantiateInitialViewController()!
        let four   = UIStoryboard.init(name: "Four", bundle: nil).instantiateInitialViewController()!

        setupChildVC(vc: home, title: "Home", image: "tabbar_home")
        setupChildVC(vc: second, title: "Second", image: "tabbar_message_center")
        setupChildVC(vc: center, title: "", image: "")
        setupChildVC(vc: third, title: "Third", image: "Order")
        setupChildVC(vc: four, title: "Four", image: "tabbar_profile")
    }
    
    func setupChildVC(vc:UIViewController, title: String, image: String) {
        vc.title = title
        
        if !image.isEmpty {
            vc.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
            let selectedImage = image + "_selected"
            vc.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        }
        
        if title == "" {
            vc.tabBarItem.tag = 1000
        }
        addChildViewController(vc)
    }
    
    func addCenterButton() {
        // 中间的按钮
        let centerBtn = UIButton(type: .custom)
        centerBtn.setImage(UIImage(named: "TabBar_Publish"), for: .normal)
        centerBtn.setImage(UIImage(named: "TabBar_Publish"), for: .highlighted)
        centerBtn.addTarget(self, action: #selector(centerClick), for: .touchUpInside)
        centerBtn.sizeToFit()
        
        let tabBar = TabBar()
        tabBar.centerButton = centerBtn
        self.setValue(tabBar, forKey: "tabBar")
    }
    
    //MARK: Action
    @objc dynamic func centerClick(sender: UIButton) {
        print("Center Button Click!")
        self.selectedIndex = 2;//关联中间按钮
        
        if self.selectItem != 2{
            rotationAnimation(button: sender)
        }
        self.selectItem = 2;
    }
    
    private func rotationAnimation(button: UIButton) {
        let rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = .pi*2.0
        rotationAnimation.duration = 3.0
        rotationAnimation.repeatCount = HUGE
        button.layer.add(rotationAnimation, forKey: "key")
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tab = self.tabBar as! TabBar
        let centerBtn = tab.centerButton
        
        if (tabBarController.selectedIndex == 2){//选中中间的按钮
            if (self.selectItem != 2){
                
                rotationAnimation(button: centerBtn)
            }
        }else {
            centerBtn.layer.removeAllAnimations()
        }
        self.selectItem = tabBarController.selectedIndex;
    }
}


