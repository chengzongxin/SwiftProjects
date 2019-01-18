//
//  EaseInAnimator.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/21.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit


// MARK: 类似天猫下拉顶部出现另外一个VC的效果
class EaseInAnimator: BaseAnimator {
    var vcCounts = 0 //navigationController 中vc的数量,用来记录是push还是pop
    
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        var isPush = false
        
        let fromVC = transitionContext.viewController(forKey: .from)
        let fromView = fromVC?.view
        
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = toVC?.view
        
        let containerView = transitionContext.containerView
        
        if vcCounts < fromVC?.navigationController?.viewControllers.count ?? 0 {
            // push
            isPush = true
        }
        vcCounts = fromVC?.navigationController?.viewControllers.count ?? 0
        
        containerView.addSubview(fromView!)
        containerView.addSubview(toView!)
        
        // 转场动画
        fromView?.isHidden = false
        toView?.isHidden = true
        
        // Create Transition Animation
        let transition = CATransition()
        transition.startProgress = 0
        transition.endProgress = 1.0
        
        transition.type = kCATransitionMoveIn
        
        if isPush {
            transition.subtype = kCATransitionFromBottom
        }else{
            transition.subtype = kCATransitionFromTop
        }
        
        transition.duration = 0.5
        
        // Add the transition animation to both layers
        
        fromView?.layer.add(transition, forKey: "transition")
        toView?.layer.add(transition, forKey: "transition")
        
        // Finally, change the visibility of the layers
        fromView?.isHidden = true
        toView?.isHidden = false
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            transitionContext.completeTransition(true)
        }
    }
}
