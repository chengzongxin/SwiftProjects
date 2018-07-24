//
//  TabBar.swift
//  SwiftProjects
//
//  Created by Jason on 2018/7/20.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class TabBar: UITabBar {

    var centerButton = UIButton(){
        /** 设置中间按钮并添加到视图 */
        didSet {
            // 去掉旧值
            if (oldValue.superview != nil) {
                oldValue.removeFromSuperview()
            }
            
            // 新值
            addSubview(centerButton)
            
            setNeedsLayout()
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 是一张小图片(width小, height正好, 所以要在不影响中间部分的情况下,将width拉长.)
        var image = UIImage(named: "tabbar_bg")!
        
        // image_的尺寸
        let imageSize = image.size
        
        // 设置右边可拉伸的地方
        image = image.stretchableImage(withLeftCapWidth: Int(imageSize.width*0.9), topCapHeight: Int(imageSize.height*0.1))
        
        // 第一次拉伸宽度=最终宽度/2+原图宽度/2 主要拉伸右边
        // 第一次拉伸宽度=最终宽度/2+原图宽度/2 主要拉伸右边
        
        let UI_SCREEN_WIDTH_OKA =  UIScreen.main.bounds.size.width
        
        let tempWidth =  UI_SCREEN_WIDTH_OKA/2 + imageSize.width/2
        
        // 右边拉伸
        UIGraphicsBeginImageContextWithOptions(CGSize(width: tempWidth, height: imageSize.height), false, UIScreen.main.scale)
        image.draw(in: CGRect(x: 0, y: 0, width: tempWidth, height: imageSize.height))
        
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // 设置左边可拉伸的地方
        image = image.stretchableImage(withLeftCapWidth: Int(image.size.width * 0.1), topCapHeight: Int(image.size.height * 0.1))
        
        let outlineView = UIImageView(frame: CGRect(x: 0, y: -21, width: UI_SCREEN_WIDTH_OKA, height: imageSize.height))
        outlineView.image = image
        
        self.insertSubview(outlineView, at: 1)
        
        self.addSubview(outlineView)
        
        
        // 去除 tabbar 的边框
        
        let rect = CGRect(x: 0, y: 0, width: UI_SCREEN_WIDTH_OKA, height: 100)
        
        // 获取一个 clear 图片
        UIGraphicsBeginImageContext(rect.size)
        
        let context =  UIGraphicsGetCurrentContext()!
        context.setFillColor(UIColor.clear.cgColor)
        context.fill(rect)
        
        let img =  UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // 设置背景有影印
        self.backgroundImage = img
        self.shadowImage = img
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.isHidden {
            if self.centerButton.frame.contains(point) {
                return self.centerButton
            }
        }
        
        return super.hitTest(point, with: event)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = bounds.size.width
        var h = bounds.size.height
        
        var btnx =  0
        
        // 5.0是tabbar中的控件的数量
        
        let width =  w/5.0
        
        
        var i =  0
        
        for btn in self.subviews {
            // 判断是否是系统自带的UITabBarButton类型的控件
            
            if btn.isKind(of: NSClassFromString("UITabBarButton")!) {
                //MARK: 会让第三个显示不出来
//                if (i == 2) {
//                    i = 3
//                }
                
                let btny =  btn.frame.origin.y
                let height =  btn.frame.size.height
                btnx = Int(CGFloat(i) * width)
                btn.frame = CGRect(x: CGFloat(btnx), y: btny, width: width, height: height)
                
                i += 1
                
                h = btny + height*0.5
            }
        }
        // 设置自定义button的位置
        self.centerButton.center = CGPoint(x: w * 0.5, y: h - 8.0)
    }
    
}
