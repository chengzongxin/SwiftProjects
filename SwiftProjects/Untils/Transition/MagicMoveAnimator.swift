//
//  MagicMoveAnimator.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/21.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class MagicMoveAnimator: BaseAnimator {
    var selectedItem = 0
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView: UIView = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: .from)!
        let toVC = transitionContext.viewController(forKey: .to)!
        
        if fromVC.isKind(of: CenterViewController.self) {
            let collectionView = fromVC.value(forKey: "collectionView") as! UICollectionView
            let cell = collectionView.cellForItem(at: (collectionView.indexPathsForSelectedItems?.first!)!) as! CenterCell
            selectedItem = collectionView.indexPathsForSelectedItems?.first?.item ?? 0
            let fromView = cell.contentView
            let toView = toVC.value(forKeyPath: "tableView.tableHeaderView") as! UIImageView
            toView.image = cell.iconImageView.image
            
            let snapShotView: UIView = UIImageView(image: cell.iconImageView.image)
            snapShotView.frame = containerView.convert(fromView.frame , from: fromView.superview)
            
            fromView.isHidden = true
            
            toVC.view.frame = transitionContext.finalFrame(for: toVC)
            toVC.view.alpha = 0
            toView.isHidden = true
            
            // titleLable
            let titleLabel = UILabel(frame: CGRect(x: 15, y: 20, width: SCREEN_WIDTH - 30, height: 30))
            titleLabel.textColor = cell.titleLabel.textColor
            titleLabel.backgroundColor = cell.titleLabel.backgroundColor
            titleLabel.textAlignment = cell.titleLabel.textAlignment
            titleLabel.font = cell.titleLabel.font
            titleLabel.text = cell.titleLabel.text
            
            // set titleLabel
            let subviewTitleLable = toVC.value(forKeyPath: "titleLabel") as! UILabel
            subviewTitleLable.textColor = cell.titleLabel.textColor
            subviewTitleLable.backgroundColor = cell.titleLabel.backgroundColor
            subviewTitleLable.textAlignment = cell.titleLabel.textAlignment
            subviewTitleLable.font = cell.titleLabel.font
            subviewTitleLable.text = cell.titleLabel.text
            subviewTitleLable.numberOfLines = cell.titleLabel.numberOfLines
            
            snapShotView.addSubview(titleLabel)
            containerView.addSubview(toVC.view)
            containerView.addSubview(snapShotView)
            
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
                containerView.layoutIfNeeded()
                toVC.view.alpha = 1.0
                snapShotView.frame = containerView.convert(toView.frame, from: toView.superview)
                // hidden tabbar
                if UIApplication.shared.statusBarFrame.size.height == 44 {
                    fromVC.tabBarController?.tabBar.frame = CGRect(x: 0, y: SCREEN_HEIGH, width: SCREEN_WIDTH, height: 83)
                } else {
                    fromVC.tabBarController?.tabBar.frame = CGRect(x: 0, y: SCREEN_HEIGH, width: SCREEN_WIDTH, height: 49)
                }
                
            }) { finished in
                
                toView.isHidden = false
                fromView.isHidden = false
                snapShotView.removeFromSuperview()
                collectionView.reloadData()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }

        }else{
            
            let fromView = fromVC.value(forKeyPath: "tableView.tableHeaderView") as! UIView
            toVC.view.frame = transitionContext.finalFrame(for: toVC)
            let collectionView = toVC.value(forKey: "collectionView") as! UICollectionView
            collectionView.reloadData()
            collectionView.layoutIfNeeded()
            let cell = collectionView.cellForItem(at: IndexPath(item: selectedItem, section: 0)) as! CenterCell
            let originView: UIView = cell.contentView
            
            let snapShotView: UIView = fromView.snapshotView(afterScreenUpdates: false)!
            snapShotView.layer.masksToBounds = true
            snapShotView.layer.cornerRadius = 15
            snapShotView.frame = containerView.convert(fromView.frame, from: fromView.superview)
            
            // titleLabel
            // set titleLabel
            let subviewTitleLable = fromVC.value(forKeyPath: "titleLabel") as! UILabel
            let titleLabel = UILabel(frame: CGRect(x: 15, y: 20, width: SCREEN_WIDTH - 30, height: 30))
            titleLabel.textColor = subviewTitleLable.textColor
            titleLabel.backgroundColor = subviewTitleLable.backgroundColor
            titleLabel.textAlignment = subviewTitleLable.textAlignment
            titleLabel.font = subviewTitleLable.font
            titleLabel.text = subviewTitleLable.text
            titleLabel.numberOfLines = subviewTitleLable.numberOfLines
            
            snapShotView.addSubview(titleLabel)
            
            fromView.isHidden = true
            originView.isHidden = true
            
            containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
            
            containerView.addSubview(snapShotView)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
                containerView.layoutIfNeeded()
                fromVC.view.alpha = 0.0
                snapShotView.layer.cornerRadius = 15
                //        self.tableView.frame = CGRect(x: self.tableView.frame.origin.x, y: self.tableView.frame.origin.y, width: self.tableView.frame.size.width, height: SCREEN_WIDTH * 1.3 * 0.8)
                //        self.tableView.layer.cornerRadius = 15
                        snapShotView.frame = containerView.convert(originView.frame, from: originView.superview)
                        titleLabel.frame = CGRect(x: 15, y: 20, width: originView.frame.width - 30, height: 60)
                //        contentLabel.frame = CGRect(x: 15, y: (SCREEN_WIDTH - 40) * 1.3 - 30, width: SCREEN_WIDTH - 44, height: 15)
//                        var tabBar = self.tabBarController?.tabBar as? Tabbar
                // show tabbar
                        if UIApplication.shared.statusBarFrame.size.height == 44 {
                            fromVC.tabBarController?.tabBar.frame = CGRect(x: 0, y: SCREEN_HEIGH - 83, width: SCREEN_WIDTH, height: 83)
                        } else {
                            fromVC.tabBarController?.tabBar.frame = CGRect(x: 0, y: SCREEN_HEIGH - 49, width: SCREEN_WIDTH, height: 49)
                        }
            }) { finished in
                fromView.isHidden = true
                snapShotView.removeFromSuperview()
                originView.isHidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}
