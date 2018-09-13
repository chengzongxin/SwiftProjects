//
//  Animation3ViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/13.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class Animation3ViewController: BaseViewController {
    
    var flag = 1
    

    lazy var view1: ShadowView = {
        let view = ShadowView(frame: CGRect(x: 50, y: 50, width: 40, height: 40))
        view.shadowBackgoundColor = UIColor.randomGradientColor(bounds: view.bounds)
        return view
    }()
    
    lazy var view2: UIView = {
        let view = UIView(frame: CGRect(x: 200, y: 50, width: 100, height: 100))
        view.backgroundColor = UIColor.flatOrange
        return view
    }()
    
    lazy var view3: UIView = {
        let view = UIView(frame: CGRect(x: 150, y: 300, width: 100, height: 100))
        view.backgroundColor = UIColor.flatOrange
        return view
    }()
    
    lazy var view4: UIView = {
        let view = UIView(frame: CGRect(x: 150, y: 300, width: 100, height: 100))
        view.backgroundColor = UIColor.flatOrange
        return view
    }()
    
    lazy var button1: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 20, y: 500, width: 150, height: 44)
        button.setTitle("path anim", for: .normal)
        button.addTarget(self, action: #selector(animation1), for: .touchUpInside)
        button.backgroundColor = UIColor.flatGray
        button.layer.roundCorners(radius: 5)
        button.layer.addShadow()
        return button
    }()
    
    lazy var button2: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 200, y: 500, width: 150, height: 44)
        button.setTitle("keyframe anim", for: .normal)
        button.addTarget(self, action: #selector(animation2), for: .touchUpInside)
        button.backgroundColor = UIColor.flatGray
        button.layer.roundCorners(radius: 5)
        button.layer.addShadow()
        return button
    }()
    
    lazy var button3: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 100, y: 550, width: 150, height: 44)
        button.setTitle("advance anim", for: .normal)
        button.addTarget(self, action: #selector(animation3), for: .touchUpInside)
        button.backgroundColor = UIColor.flatGray
        button.layer.roundCorners(radius: 5)
        button.layer.addShadow()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(view1)
        
        view.addSubview(view2)
        
        view.addSubview(view3)
        
        view.addSubview(view4)
        
        view.addSubview(button1)
        
        view.addSubview(button2)
        
        view.addSubview(button3)
    }
    
    @objc private func animation1() {
        // Create Path
        let thePath = CGMutablePath()
        thePath.move(to: CGPoint(x: 100, y: 100), transform: .identity)
        thePath.addCurve(to: CGPoint(x: 74, y: 500), control1: CGPoint(x: 320, y: 500), control2: CGPoint(x: 320, y: 74))
        thePath.addCurve(to: CGPoint(x: 320, y: 500), control1: CGPoint(x: 566, y: 500), control2: CGPoint(x: 566, y: 74))
        
        // Create Animation
        let theAnimation = CAKeyframeAnimation(keyPath: "position")
        theAnimation.path = thePath
        theAnimation.duration = 5.0
        
        // Add Animation
        view1.layer.add(theAnimation, forKey: "position")
    }
    
    @objc private func animation2() {
        // Animation 1
        let widthAnim = CAKeyframeAnimation(keyPath: "borderWidth")
        widthAnim.values = [1.0, 10.0, 5.0, 30.0, 0.5, 15.0, 2.0, 50.0, 0.0]
        widthAnim.calculationMode = kCAAnimationPaced
        
        // Animation 2
        let colorAnim = CAKeyframeAnimation(keyPath: "borderColor")
        colorAnim.values = [UIColor.red, UIColor.yellow, UIColor.blue]
        colorAnim.calculationMode = kCAAnimationPaced
        
        // Animation 3
        let cornerAnim = CAKeyframeAnimation(keyPath: "cornerRadius")
        cornerAnim.values = [0.0, 50.0, 0.0]
        cornerAnim.calculationMode = kCAAnimationPaced
        
        // Animation group
        let group = CAAnimationGroup()
        group.animations = [widthAnim,colorAnim,cornerAnim]
        group.duration = 5.0
        
        view1.layer.add(group, forKey: "BorderChanges")
        view2.layer.add(group, forKey: "BorderChanges")
    }
    
    @objc private func animation3() {
        
        view3.isHidden = false
        view4.isHidden = true
        
        // Create Transition Animation
        let transition = CATransition()
        transition.startProgress = 0
        transition.endProgress = 1.0
//        transition.type = kCATransitionPush
//        transition.subtype = kCATransitionFromRight
        transition.duration = 1.0
        
        switch flag {
        case 1:
            transition.type = kCATransitionFade
            transition.subtype = kCATransitionFromBottom
        case 2:
            transition.type = kCATransitionMoveIn
            transition.subtype = kCATransitionFromBottom
        case 3:
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromBottom
        case 4:
            transition.type = kCATransitionReveal
            transition.subtype = kCATransitionFromBottom
        default: break
            
        }
        
        // Add the transition animation to both layers
        view3.layer.add(transition, forKey: "transition")
        view4.layer.add(transition, forKey: "transition")
        
        // Finally, change the visibility of the layers
        view3.isHidden = true
        view4.isHidden = false
        
        flag += 1
    }
}
