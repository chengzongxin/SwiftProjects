//
//  FilterView.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/26.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import PLShortVideoKit

typealias swiftBlock = (PLSFilter) -> Void

class FilterView: UIView ,UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var collectionView: UICollectionView!
    
    var filterGroup: PLSFilterGroup!
    
    var callBack: swiftBlock?
    
    
    func didSelect(callBack: @escaping swiftBlock) {
        self.callBack = callBack
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "FilterView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        filterGroup = PLSFilterGroup()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "FilterCell", bundle: nil), forCellWithReuseIdentifier: "FilterCell")
        
        collectionView.reloadData()
    }
    
}

extension FilterView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterGroup.filtersInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
//        ["name": name ?? 0, "dir": dir ?? 0, "coverImagePath": coverImagePath, "colorImagePath": colorImagePath, "coverImage": anImage]
        let filterInfoDict = filterGroup.filtersInfo[indexPath.item]
        
        cell.topImageView.image = UIImage(contentsOfFile: filterInfoDict["coverImagePath"] as! String)
        cell.bottomLabel.text = filterInfoDict["name"] as? String
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filterInfoDict = filterGroup.filtersInfo[indexPath.item]
        
        print(filterInfoDict)
        
        filterGroup.filterIndex = indexPath.row
        if let callBack = callBack {
            callBack(filterGroup.currentFilter!)
        }
    }
}
