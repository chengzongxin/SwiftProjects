//
//  LargeValueFormatter.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/18.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import Charts

class LargeValueFormatter: NSObject, IValueFormatter, IAxisValueFormatter {
    
    fileprivate func format(value: Double) -> String {
        
        return "\(value)" + "%"
    }
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return format(value: value)
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return format(value: value)
    }
}
