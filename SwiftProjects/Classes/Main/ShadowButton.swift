//
//  ShadowButton.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/6.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class ShadowButton: UIButton {

    var shadowLayer: CAShapeLayer?
    
    @IBInspectable
    var shadowBackgoundColor: UIColor! = UIColor.darkGray {
        didSet {
            shadowLayer?.removeFromSuperlayer()
            
            shadowLayer = CAShapeLayer()
            shadowLayer?.path = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
            shadowLayer?.fillColor = shadowBackgoundColor.cgColor
            
            shadowLayer?.shadowColor = UIColor.darkGray.cgColor
            shadowLayer?.shadowPath = shadowLayer?.path
            shadowLayer?.shadowOffset = CGSize(width: 5.0, height: 5.0)
            shadowLayer?.shadowOpacity = 0.8
            shadowLayer?.shadowRadius = 2
            
            layer.insertSublayer(shadowLayer!, at: 0)
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer?.path = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
            shadowLayer?.fillColor = UIColor.randomGradientColor(bounds: bounds).cgColor
            
            shadowLayer?.shadowColor = UIColor.darkGray.cgColor
            shadowLayer?.shadowPath = shadowLayer?.path
            shadowLayer?.shadowOffset = CGSize(width: 5.0, height: 5.0)
            shadowLayer?.shadowOpacity = 0.8
            shadowLayer?.shadowRadius = 2
            
            layer.insertSublayer(shadowLayer!, at: 0)
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }

}
