//
//  Animation1ViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/5.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class Animation1ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Animation 1"
        
        let view1 = ShadowView(frame: CGRect(x: 0, y: 20, width: 100, height: 100))
        view1.shadowBackgoundColor = UIColor.flatGreen
        view.addSubview(view1)
        
        let view2 = UIView(frame: CGRect(x: 130, y: 20, width: 100, height: 100))
        view2.backgroundColor = UIColor.randomGradientColor(bounds: view2.bounds)
        view2.layer.roundCorners(radius: 12)
        view2.layer.addShadow()
        view.addSubview(view2)
        
        let view3 = UIView(frame: CGRect(x: 260, y: 20, width: 100, height: 100))
        view3.layer.roundCorners(radius: 12)
        view3.layer.addShadowLayer()
        view.addSubview(view3)
        
    }
    
    override public func buttonClick() {
        super.buttonClick()
        
        
        UIView.animate(withDuration: 1.0, animations: {
            // Change the opacity imlicitly
            self.myView.layer.opacity = 0.0
            
            // Change the position explicitly
            let theAnim = CABasicAnimation(keyPath: "position")
            theAnim.fromValue = self.myView.layer.position
            theAnim.toValue = CGPoint(x: 0, y: 0)
            theAnim.duration = 3.0
            self.myView.layer.add(theAnim, forKey: "AnimateFrame")
        }) { (finish) in
            self.myView.layer.opacity = 1.0
        }
    }
}
