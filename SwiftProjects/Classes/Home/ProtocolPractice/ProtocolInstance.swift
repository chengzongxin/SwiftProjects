//
//  ProtocolInstance.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/19.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class ProtocolInstance: NSObject, ProtocolPractice {
    var test: String = "Click Blank Area call protocol \"practice\" method."
    
    func practice() -> String {
        return Date().description
    }
}
