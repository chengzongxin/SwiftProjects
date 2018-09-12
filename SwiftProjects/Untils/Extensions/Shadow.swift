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
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = UIColor.green.cgColor
        
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        shadowLayer.shadowOpacity = 0.5
        shadowLayer.shadowRadius = 2
        
        self.insertSublayer(shadowLayer, at: 0)
    }
    
    func addShadowLayer() {
        self.shadowOpacity = 0.5
        self.shadowRadius = 10
        self.shadowColor = UIColor.black.cgColor
        self.shadowOffset = CGSize(width: 5, height: 5)
        self.masksToBounds = false
        let rect = self.bounds.insetBy(dx: -5, dy: -5)
        self.shadowPath = UIBezierPath(rect: rect).cgPath
    }
    
    
}
