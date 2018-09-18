//
//  ChartMarker.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/18.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import Charts

class ChartMarker: NSObject, IMarker {
    var offset: CGPoint = CGPoint.zero
    
    var markText = ""
    
    var textFontSize: CGFloat = 12.0
    
    override init() {
        super.init()
    }
    
    func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        markText = String(entry.y)
    }
    
    func draw(context: CGContext, point: CGPoint) {
        let ooffset: CGPoint = offsetForDrawing(atPoint: point)
        let frame = CGRect(x: UIScreen.main.bounds.width + ooffset.x - 15, y: point.y + ooffset.y + 5, width: size().width, height: size().height)
        context.setFillColor(UIColor.flatBlue.cgColor)
        context.saveGState()
        context.beginPath()
        context.addRect(frame)
        context.strokePath()
        context.fill(frame)
        UIGraphicsPushContext(context)
        markText.draw(in: frame, withAttributes: [NSAttributedStringKey.foregroundColor: UIColor.white,
                                                  NSAttributedStringKey.font: UIFont.systemFont(ofSize: textFontSize)])
        UIGraphicsPopContext()
        context.restoreGState()

    }
    

    func offsetForDrawing(atPoint: CGPoint) -> CGPoint {
        let textSize = CGSize(width: 25, height: 25)
        let actualSize = size()
        return CGPoint(x: -(textSize.width + (actualSize.width / 2)) / 2, y: -(textSize.height - actualSize.height))
    }
    
    func size() -> CGSize {
        return markText.size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: textFontSize)])
    }
}
