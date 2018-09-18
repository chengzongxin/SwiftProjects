//
//  DateValueFormatter.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/18.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import Charts

class DateValueFormatter: NSObject, IAxisValueFormatter{
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "HH:mm:ss"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dateFormatter.string(from: Date(timeInterval: value, since: Date()))
    }
}
