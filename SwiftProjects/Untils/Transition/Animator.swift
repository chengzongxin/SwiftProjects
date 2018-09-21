//
//  Animator.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/21.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class Animator: BaseAnimator {
    var cell:SecondCell!
    
    
    // MARK: - Animator Universal Delagte
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toVC = transitionContext.viewController(forKey: .to) as? Animation3ViewController
        let toView = toVC?.view
        let fromView: UIView? = cell.contentView.subviews[0]
        let containerView: UIView? = transitionContext.containerView
        let snapShotView: UIView? = cell.contentView
        snapShotView?.frame = containerView?.convert(fromView?.frame ?? CGRect.zero, from: fromView?.superview) ?? CGRect.zero
        
        fromView?.isHidden = true
        
        if let aVC = toVC {
            toVC?.view.frame = transitionContext.finalFrame(for: aVC)
        }
        toVC?.view.alpha = 0
        toView?.isHidden = true
        
        let titleLabel = UILabel(frame: CGRect(x: 15, y: 20, width: SCREEN_WIDTH - 30, height: 30))
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 25)
        titleLabel.text = cell.titleLabel?.text
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            containerView?.layoutIfNeeded()
            toVC?.view.alpha = 1.0
//            var tabBar = self.tabBarController?.tabBar as? Tabbar
//            if IPHONE_X {
//                tabBar?.frame = CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 83)
//            } else {
//                tabBar?.frame = CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 49)
//            }
            snapShotView?.frame = containerView?.convert(toView?.frame ?? CGRect.zero, from: toView?.superview) ?? CGRect.zero
            titleLabel.frame = CGRect(x: 22, y: 30, width: SCREEN_WIDTH - 30, height: 30)
//            contentLabel.frame = CGRect(x: 22, y: SCREEN_WIDTH * 1.3 - 30, width: SCREEN_WIDTH * 1.3 - 44, height: 15)
            
        }) { finished in
            
            toView?.isHidden = false
            fromView?.isHidden = false
            snapShotView?.removeFromSuperview()
            // 通知完成转场
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }

}

