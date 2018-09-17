//
//  ChartsViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/17.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import Charts

class ChartsViewController: UIViewController {

    @IBOutlet weak var lineView: LineChartView!
    
    lazy var dataSouce: [Int] = {
        var datas = [Int]()
        for _ in 0..<30 {
            datas.append(Int(arc4random() % 100))
        }
        print(datas)
        return datas
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLineView()
        
        setLineData()
    }
    
    func setLineView() {
        lineView.leftAxis.enabled = false
        lineView.doubleTapToZoomEnabled = false
        lineView.scaleYEnabled = false
        lineView.xAxis.labelPosition = .bottom
        lineView.rightAxis.labelPosition = .outsideChart
        lineView.xAxis.labelTextColor = UIColor.randomFlat
        lineView.rightAxis.labelTextColor = lineView.xAxis.labelTextColor
    }
    
    func setLineData() {
        
        // 1.Crate Data Entry
        var dataEntry = [ChartDataEntry]()
        for (i, item) in dataSouce.enumerated() {
            dataEntry.append(ChartDataEntry(x: Double(i), y: Double(item)))
        }
        
        // 2.Create Data Set
        let dataSet1 = LineChartDataSet(values: dataEntry, label: "Data Set 1")
        dataSet1.setColor(UIColor.randomFlat)
        dataSet1.valueTextColor = UIColor.randomFlat
        dataSet1.drawCirclesEnabled = false  // Circle
        
        // 3.Set Chart Data
        let chartData = LineChartData(dataSets: [dataSet1])
        lineView.data = chartData
        lineView.notifyDataSetChanged()
    }

}
