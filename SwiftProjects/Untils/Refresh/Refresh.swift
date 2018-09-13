//
//  Refresh.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/13.
//  Copyright © 2018年 Jason. All rights reserved.
//

import Foundation
import UIKit
import ESPullToRefresh

extension UIScrollView {
    func addPullToRefresh(handler: @escaping () -> ()) {
        self.es.addPullToRefresh(animator: MTRefreshHeaderAnimator(), handler: handler)
    }
    
    func addInfiniteScrolling(handler: @escaping () -> ()) {
        self.es.addInfiniteScrolling(animator: MTRefreshFooterAnimator(), handler: handler)
    }
}
