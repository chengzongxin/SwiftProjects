//
//  SecondViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/7/20.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

let secondCellID = "seconCellID"


class SecondViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    lazy var dataSouces: [String] = {
        var dataSouces: [String] = []
        
        for i in 0..<100 {
            dataSouces.append("\(i)")
        }
        
        return dataSouces
    }()
    
    lazy var collectionView: UICollectionView = {
        // Layout
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = UICollectionViewScrollDirection.vertical // 设置水平显示
        
        layout.itemSize = CGSize(width: (view.frame.size.width - 40) / 3, height: (view.frame.size.width - 40) / 3)
        
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        layout.minimumLineSpacing = 10.0
        
        layout.minimumInteritemSpacing = 10.0
        
        // CollectionView
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.randomFlat
        
        collectionView.register(UINib.init(nibName: "SecondCell", bundle: nil), forCellWithReuseIdentifier: secondCellID)
        
        collectionView.delaysContentTouches = false
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
        
        // Gesture
        let longPressGes = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(_:)))
        
        collectionView.addGestureRecognizer(longPressGes)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.randomGradientColor(bounds: view.bounds)
        
        view.addSubview(collectionView)
    }
    
    @objc fileprivate func longPressAction(_ gesture: UILongPressGestureRecognizer) {
        // 判断长按的状态
        switch gesture.state {
        case .began:
            // 获取选择位置
            // indexPathForItem获取Item所处的indexPath
            // indexPath是表格或列表推算出当前row和col的属性
            // ***GestureRecognizer的location方法返回在所处view的一个CGPoint属性
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else { return }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            
            // 放大效果
            let targetCell = collectionView.cellForItem(at: selectedIndexPath)
            UIView.animate(withDuration: 0.2) {
                targetCell?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2);
            }
        case .changed:
            // 移动了
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
        case .ended:
            // 结束移动
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
}

extension SecondViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSouces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: secondCellID, for: indexPath) as! SecondCell
        
        cell.backgroundColor = UIColor.randomGradientColor(bounds: cell.bounds)
        
        cell.titleLabel.text = dataSouces[indexPath.item]
        
        return cell;
    }
    
    // 实现重排的关键
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tmpCell = dataSouces.remove(at: sourceIndexPath.item)
        dataSouces.insert(tmpCell, at: destinationIndexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        
        let vc: UIViewController
        
        switch indexPath.item {
        case 0:
            vc = BaseViewController()
        case 1:
            vc = Animation1ViewController()
        default:
            vc = UIViewController()
        }
        
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}




