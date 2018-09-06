//
//  Shadow.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/6.
//  Copyright © 2018年 Jason. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    func roundCorners(radius: CGFloat) {
        self.cornerRadius = radius
    }
}

extension CALayer {
    func addShadow() {
        self.shadowOpacity = 0.5
        self.shadowRadius = 10
        self.shadowColor = UIColor.black.cgColor
        self.shadowOffset = CGSize(width: 10, height: 10)
        self.masksToBounds = false
        let rect = self.bounds.insetBy(dx: -10, dy: -10)
        self.shadowPath = UIBezierPath(rect: rect).cgPath
    }
}
