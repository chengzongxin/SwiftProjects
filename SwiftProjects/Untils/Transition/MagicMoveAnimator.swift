//
//  MagicMoveAnimator.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/21.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class MagicMoveAnimator: BaseAnimator {
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: .from)
        let fromView = fromVC?.view
        
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = toVC?.view
        
        let containerView = transitionContext.containerView
        containerView.addSubview(fromView!)
        containerView.addSubview(toView!)
        
        // 转场动画
        fromView?.isHidden = false
        toView?.isHidden = true
        
        // Create Transition Animation
        let transition = CATransition()
        transition.startProgress = 0
        transition.endProgress = 1.0
//                transition.type = kCATransitionPush
//                transition.subtype = kCATransitionFromRight
        
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromBottom
        transition.duration = 0.2
        
//        switch flag {
//        case 1:
//            transition.type = kCATransitionFade
//            transition.subtype = kCATransitionFromBottom
//        case 2:
//            transition.type = kCATransitionMoveIn
//            transition.subtype = kCATransitionFromBottom
//        case 3:
//            transition.type = kCATransitionPush
//            transition.subtype = kCATransitionFromBottom
//        case 4:
//            transition.type = kCATransitionReveal
//            transition.subtype = kCATransitionFromBottom
//        default: break
//
//        }
        
        // Add the transition animation to both layers
        fromView?.layer.add(transition, forKey: "transition")
        toView?.layer.add(transition, forKey: "transition")
        
        // Finally, change the visibility of the layers
        fromView?.isHidden = true
        toView?.isHidden = false
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            transitionContext.completeTransition(true)
        }
    }
}
