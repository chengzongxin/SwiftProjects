//
//  MagicMoveAnimator.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/21.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class MagicMoveAnimator: NSObject, UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate {
    
    // MARK: - Animator Universal Delagte
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
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
        UIView.animate(withDuration: 0.2, animations: {
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
    
    // MARK: - Present Modal Delegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }

    // MARK: - Push&Pop Modal Delagte
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationControllerOperation.push {
            return self
        }

        if operation == UINavigationControllerOperation.pop {
            return self
        }
        
        return nil
    }
}
