//
//  PrefixHeader.swift
//  SwiftProjects
//
//  Created by Jason on 2018/7/20.
//  Copyright © 2018年 Jason. All rights reserved.
//

import Foundation
import ChameleonFramework

//获取屏幕宽度  高度
let  SCREEN_WIDTH = UIScreen.main.bounds.height

let  SCREEN_HEIGH = UIScreen.main.bounds.height

//颜色获取(定义方法)
func RGBA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
