//
//  Animator.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/21.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

// MARk: 渐变 视图从0到1渐变
class GradientAnimator: BaseAnimator {
    var cell:SecondCell!
    
    
    // MARK: - Animator Universal Delagte
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: .from)
        let fromView = fromVC?.view
        
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = toVC?.view
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView!)
        containerView.addSubview(fromView!)
        
        // 转场动画
        toView?.alpha = 1
        UIView.animate(withDuration: 0.4, animations: {
            fromView?.alpha = 0
            
            
        }, completion: { finished in
            UIView.animate(withDuration: 0.2, animations: {
                toView?.alpha = 1
                toView?.backgroundColor = UIColor.randomGradientColor(bounds: toView!.bounds)
            }, completion: { finished in
                
                // 通知完成转场
                transitionContext.completeTransition(true)
            })
            
        })
    }

}

