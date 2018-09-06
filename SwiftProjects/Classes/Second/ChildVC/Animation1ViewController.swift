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
