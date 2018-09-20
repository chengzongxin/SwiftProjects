//
//  ProgressHub.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/20.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import SVProgressHUD

extension AppDelegate {
    func configProgressHub() {
        SVProgressHUD.setMinimumSize(CGSize(width: 120, height: 120))
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 12))
        SVProgressHUD.setBackgroundColor(UIColor.black.withAlphaComponent(0.5))
        SVProgressHUD.setMaximumDismissTimeInterval(15)
        
        var images: [UIImage] = []
        for i in 1...8 {
            let imageName = String(format: "icon_shake_animation_\(i)")
            let image = UIImage(named: imageName)
            if let anImage = image {
                images.append(anImage)
            }
        }
        
        // Set InfoImage animate images
        let animateImage = UIImage.animatedImage(with: images, duration: 1.0) ?? UIImage()

        SVProgressHUD.setInfoImage(animateImage)
        SVProgressHUD.setMaximumDismissTimeInterval(15)
        SVProgressHUD.setImageViewSize(animateImage.size)
    }
}
