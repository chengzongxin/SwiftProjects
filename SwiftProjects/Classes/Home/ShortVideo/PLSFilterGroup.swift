//
//  PLSFilterGroup.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/25.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import PLShortVideoKit

class PLSFilterGroup: NSObject {
    /**
     @abstract 所有滤镜的信息，NSDictionary 的 key 为 name，coverImagePath，colorImagePath，分别为一个滤镜的名称，封面，滤镜图片
     */
    var filtersInfo: [[AnyHashable : Any]] = [[:]]
    /**
     @abstract 当前使用的滤镜在滤镜组中的索引
     */
    var filterIndex: Int = 0 {
        didSet {
            colorImagePath = colorFilterArray[filterIndex] as! String
            currentFilter?.colorImagePath = colorImagePath
        }
    }
    /**
     @abstract 当前使用的滤镜的颜色表图的路径
     */
    var colorImagePath: String = ""
    /**
     @abstract 当前使用的滤镜
     */
    var currentFilter: PLSFilter?
    /**
     @abstract 使用 inputImage 作为滤镜的封面图
     */
    init(image inputImage: UIImage) {
        super.init()
    }
    
    private var colorFilterArray: [AnyHashable] = []
    /**
     @abstract 将图片作为滤镜封面
     */
    private var coverImage: UIImage?
    
    override init() {
        super.init()
        
        colorFilterArray = [AnyHashable]()
        filtersInfo = [AnyHashable]() as! [[AnyHashable : Any]]
        currentFilter = PLSFilter()
        setupFilter()
    }
    
    init?(inputImage: UIImage) {
        super.init()
        
        coverImage = inputImage
        colorFilterArray = [AnyHashable]()
        filtersInfo = [AnyHashable]() as! [[AnyHashable : Any]]
        currentFilter = PLSFilter()
        setupFilter()
    }
    func setupFilter() {
        loadFilters(coverImage)
    }
    
    func loadFilters(_ inputImage: UIImage?) {
        if filtersInfo.isEmpty == false {
            filtersInfo.removeAll()
        }
        if colorFilterArray.isEmpty == false {
            colorFilterArray.removeAll()
        }
        let bundlePath = Bundle.main.bundlePath
        let filtersPath = bundlePath + ("/PLShortVideoKit.bundle/colorFilter")
        let jsonPath = filtersPath + ("/plsfilters.json")
        let data = NSData(contentsOfFile: jsonPath) as Data?
        //        var error: Error?
        var dicFromJson: [AnyHashable : Any]? = nil
        if let aData = data {
            dicFromJson = try! JSONSerialization.jsonObject(with: aData, options: .allowFragments) as? [AnyHashable : Any]
        }
        //        if let anError = error {
        //            print("load internal filters json error: \(anError)")
        //        }
        let array = dicFromJson?["filters"] as? [Any]
        for i in 0..<(array?.count ?? 0) {
            let filter = array?[i] as? [AnyHashable : Any]
            let name = filter?["name"] as? String
            let dir = filter?["dir"] as? String
            let coverImagePath = filtersPath + ("/\(dir ?? "")/thumb.png")
            let colorImagePath = filtersPath + ("/\(dir ?? "")/filter.png")
            var coverImage: UIImage?
            if (self.coverImage != nil) {
                coverImage = PLSFilter.apply(self.coverImage, colorImagePath: colorImagePath)
            } else {
                coverImage = nil
            }
//            var dic: [String : Any?]? = nil
//            if let anImage = coverImage {
//                dic = ["name": name ?? 0, "dir": dir ?? 0, "coverImagePath": coverImagePath, "colorImagePath": colorImagePath, "coverImage": anImage]
//            }
            
            let dic = ["name": name ?? 0, "dir": dir ?? 0, "coverImagePath": coverImagePath, "colorImagePath": colorImagePath, "coverImage": coverImage ?? UIImage()] as [String : Any]
            filtersInfo.append(dic)
            colorFilterArray.append(colorImagePath)
        }
    }

}
