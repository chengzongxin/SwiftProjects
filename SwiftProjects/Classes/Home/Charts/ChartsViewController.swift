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
    
    @IBOutlet weak var barView: BarChartView!
    
    lazy var lineDatas: [Int] = {
        var datas = [Int]()
        for _ in 0..<30 {
            datas.append(Int(arc4random() % 100))
        }
        return datas
    }()
    
    lazy var barDatas: [Int] = {
        var datas = [Int]()
        for _ in 0..<30 {
            datas.append(Int(arc4random() % 100))
        }
        return datas
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLineView()
        
        setLineData()
        
        setBarView()
        
        setBarData()
    }
    
    // MARK: - LineView Config
    func setLineView() {
        lineView.leftAxis.enabled = false
        lineView.doubleTapToZoomEnabled = false
        lineView.scaleYEnabled = false
        lineView.xAxis.labelPosition = .bottom
        lineView.rightAxis.labelPosition = .outsideChart
        lineView.xAxis.labelTextColor = UIColor.randomFlat
        lineView.rightAxis.labelTextColor = lineView.xAxis.labelTextColor
        
        // Set Right-axis
        let rightAxis = lineView.rightAxis
        rightAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        rightAxis.valueFormatter = LargeValueFormatter()
        rightAxis.spaceTop = 0.35
        rightAxis.axisMinimum = 0
        
        // Set X-axis
        let xAxis = lineView.xAxis
        xAxis.valueFormatter = DateValueFormatter()
        xAxis.granularity = 1
        
        // Set Marker
        lineView.marker = ChartMarker()
        
        lineView.animate(xAxisDuration: 2.5, yAxisDuration: 2.5)
    }
    // MARK: - LineView DataSource
    func setLineData() {
        
        // 1.Crate Data Entry
        var dataEntry = [ChartDataEntry]()
        for (i, item) in lineDatas.enumerated() {
            dataEntry.append(ChartDataEntry(x: Double(i), y: Double(item)))
        }
        
        // 2.Create Data Set
        let dataSet1 = LineChartDataSet(values: dataEntry, label: "Data Set 1")
        dataSet1.setColor(UIColor.randomFlat)
        dataSet1.valueTextColor = UIColor.randomFlat
        dataSet1.drawCirclesEnabled = false  // Circle
        
        let gradientColors = [UIColor.randomFlat.cgColor,
                              UIColor.randomFlat.cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        dataSet1.fillAlpha = 1
        dataSet1.fill = Fill(linearGradient: gradient, angle: 90) //.linearGradient(gradient, angle: 90)
        dataSet1.drawFilledEnabled = true
        
        // 3.Set Chart Data
        let chartData = LineChartData(dataSets: [dataSet1])
        lineView.data = chartData
        lineView.notifyDataSetChanged()
    }
    
    
    // MARK: - BarView Config
    func setBarView() {
        barView.leftAxis.enabled = false
        barView.doubleTapToZoomEnabled = false
        barView.scaleYEnabled = false
        barView.xAxis.labelPosition = .bottom
        barView.rightAxis.labelPosition = .outsideChart
        barView.xAxis.labelTextColor = UIColor.randomFlat
        barView.rightAxis.labelTextColor = lineView.xAxis.labelTextColor
        barView.animate(xAxisDuration: 2.5, yAxisDuration: 2.5)
    }
    
    // MARK: - BarView DataSource
    func setBarData() {
        
        // 1.Crate Data Entry
        var dataEntry = [BarChartDataEntry]()
        for (i, item) in barDatas.enumerated() {
            dataEntry.append(BarChartDataEntry(x: Double(i), y: Double(item)))
        }
        
        // 2.Create Data Set
        let dataSet1 = BarChartDataSet(values: dataEntry, label: "Data Set 1")
        dataSet1.setColor(UIColor.randomFlat)
        dataSet1.valueTextColor = UIColor.randomFlat
        
        // 3.Set Chart Data
        let chartData =  BarChartData(dataSets: [dataSet1])
        barView.data = chartData
        barView.notifyDataSetChanged()
    }
    

}
