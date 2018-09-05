//
//  RandomColor.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/5.
//  Copyright © 2018年 Jason. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static public func randomGradientColor(bounds: CGRect) -> UIColor {
        return UIColor(gradientStyle: .topToBottom, withFrame: bounds, andColors: [UIColor.randomFlat,UIColor.randomFlat])
    }

}
