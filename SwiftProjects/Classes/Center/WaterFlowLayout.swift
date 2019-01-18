//
//  WaterFlowLayout.swift
//  SwiftProjects
//
//  Created by Jason on 2019/1/18.
//  Copyright © 2019 Jason. All rights reserved.
//

import UIKit
protocol WaterFlowLayoutDelegate: AnyObject {
    func itemHeight(at indexPath: IndexPath) -> CGFloat
}

class WaterFlowLayout: UICollectionViewLayout {

    //总列数
    var columnCount = 2
    //列间距
    var columnSpacing: CGFloat = 10.0
    //行间距
    var rowSpacing: CGFloat = 10.0
    //section到collectionView的边距
    var sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10)
    //保存每一列最大y值的数组
    var maxY:[CGFloat] = [0,0]
    //保存每一个item的attributes的数组
    var attributesArray:[UICollectionViewLayoutAttributes] = []
    //代理，用来计算item的高度
    weak var delegate: WaterFlowLayoutDelegate?
    
    override func prepare() {
        super.prepare()
         // 初始化字典，有几列就有几个键值对，key为列，value为列的最大y值，初始值为上内边距
        for i in 0..<columnCount {
            maxY[i] = sectionInsets.top
        }
        // 根据collectionView获取总共有多少个item
        let itemCount = collectionView?.numberOfItems(inSection: 0) ?? 0
        attributesArray.removeAll()
        //为每一个item创建一个attributes并存入数组
        for i in 0..<itemCount {
            let attributes = self.layoutAttributesForItem(at: IndexPath.init(item: i, section: 0))!
            attributesArray.append(attributes)
        }
    }
    
    override var collectionViewContentSize: CGSize {
        //遍历字典，找出最长的那一列
        var max: CGFloat = 0.0
        for (_, num) in maxY.enumerated() {
            if max < num {
                max = num
            }
        }
        //collectionView的contentSize.height就等于最长列的最大y值+下内边距
        return CGSize(width: 0, height: max)
    }
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        //根据indexPath获取item的attributes
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
//        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//
//        //获取collectionView的宽度
        let collectionViewWidth = collectionView?.frame.size.width ?? 0
//        CGFloat collectionViewWidth = self.collectionView.frame.size.width;
//
//        //item的宽度 = (collectionView的宽度 - 内边距与列间距) / 列数
        let itemWidth = (collectionViewWidth - sectionInsets.left - sectionInsets.right - CGFloat((columnCount - 1)) * columnSpacing) / CGFloat(columnCount)
//        CGFloat itemWidth = (collectionViewWidth - self.sectionInset.left - self.sectionInset.right - (self.columnCount - 1) * self.columnSpacing) / self.columnCount;
//
        var itemHeight: CGFloat = 0.0
//        CGFloat itemHeight = 0;
//        //获取item的高度，由外界计算得到
        if let delegate = self.delegate {
            itemHeight = delegate.itemHeight(at: indexPath)
        }
//        if ([self.delegate respondsToSelector:@selector(waterfallLayout:itemHeightForWidth:atIndexPath:)])
//        itemHeight = [self.delegate waterfallLayout:self itemHeightForWidth:itemWidth atIndexPath:indexPath];
//
//        //找出最短的那一列
        var column = CGFloat.greatestFiniteMagnitude
        var minColumn = 0
        for (idx, num) in maxY.enumerated() {
            if column > num {
                column = num
                minColumn = idx
            }
        }
//        __block NSNumber *minIndex = @0;
//        [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL *stop) {
//        if ([self.maxYDic[minIndex] floatValue] > obj.floatValue) {
//        minIndex = key;
//        }
//        }];
//
//        //根据最短列的列数计算item的x值
        let itemX = sectionInsets.left + (columnSpacing + itemWidth) * CGFloat(minColumn)
//        CGFloat itemX = self.sectionInset.left + (self.columnSpacing + itemWidth) * minIndex.integerValue;
//
//        //item的y值 = 最短列的最大y值 + 行间距
        let itemY = maxY[minColumn] + rowSpacing
//        CGFloat itemY = [self.maxYDic[minIndex] floatValue] + self.rowSpacing;
//
//        //设置attributes的frame
        attributes.frame = CGRect(x: itemX, y: itemY, width: itemWidth, height: itemHeight)
//        attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
//
//        //更新字典中的最大y值
        maxY[minColumn] = attributes.frame.maxY 
        return attributes
//        self.maxYDic[minIndex] = @(CGRectGetMaxY(attributes.frame));
//
//        return attributes;
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesArray
    }
}
