//
//  Animator.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/20.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // 定义转场动画为0.8秒
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    // 具体的转场动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let fromView = fromVC?.view
        
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = toVC?.view
        
        let containerView = transitionContext.containerView
        containerView.addSubview(fromView!)
        containerView.addSubview(toView!)
        
        // 转场动画
        toView?.alpha = 0
        UIView.animate(withDuration: 0.4, animations: {
            fromView?.alpha = 0
            
            
        }, completion: { finished in
            UIView.animate(withDuration: 0.4, animations: {
                toView?.alpha = 1
                
            }, completion: { finished in
                
                // 通知完成转场
                transitionContext.completeTransition(true)
            })
            
        })
        
        
    }
}


