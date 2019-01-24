//
//  CenterViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/7/24.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

@objcMembers  // support kvc
class CenterViewController: UIViewController, WaterFlowLayoutDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: 设置转场代理器
    var animator: Any?
    
    
    lazy var dataSouces: [(title:String, image:UIImage)] = {
        var dataSouces: [(title:String, image:UIImage)] = []
        
        for i in 1...17 {
            var title: String!
            switch i {
            case 1:
                title = "BaseAnimator 基类渐变"
            case 2:
                title = "EaseInAnimator 从上往下转场,类似淘宝"
            case 3:
                title = "GradientAnimator alpha 渐变"
            case 4:
                title = "MagicMoveAnimator 类似App Store"
            default:
                title = "MagicMoveAnimator 类似App Store"
            }
            
            let name = (i == 8 || i == 13 ? "huoying\(i).png" : "huoying\(i).jpg")
            let path = Bundle.main.path(forResource: name, ofType: nil)!
            let image = UIImage(contentsOfFile: path)!
            
            dataSouces.append((title, image))
        }
        
        return dataSouces
    }()

    lazy var collectionView: UICollectionView = {
        // Layout
        let layout = WaterFlowLayout()
        
        layout.delegate = self
        
        // CollectionView
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.flatWhite
        
        collectionView.register(UINib.init(nibName: "CenterCell", bundle: nil), forCellWithReuseIdentifier: "CenterCell")
        
        collectionView.delaysContentTouches = false
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
        // refresh
        collectionView.addPullToRefresh {
            [unowned self] in

            self.dataSouces.removeAll()

            self.loadDatas()

            self.collectionView.reloadData()
            self.collectionView.es.stopPullToRefresh()
        }
        
        collectionView.addInfiniteScrolling {
            [unowned self] in
            
            self.dataSouces += self.dataSouces
            self.collectionView.reloadData()
            self.collectionView.es.stopLoadingMore()
        }
        
        return collectionView
    }()

    private func loadDatas() {
        for i in 1...17 {
            var title: String!
            switch i {
            case 1:
                title = "BaseAnimator 基类渐变"
            case 2:
                title = "EaseInAnimator 从上往下转场,类似淘宝"
            case 3:
                title = "GradientAnimator alpha 渐变"
            case 4:
                title = "MagicMoveAnimator 类似App Store"
            default:
                title = "MagicMoveAnimator 类似App Store"
            }
            
            let name = (i == 8 || i == 13 ? "huoying\(i).png" : "huoying\(i).jpg")
            let path = Bundle.main.path(forResource: name, ofType: nil)!
            let image = UIImage(contentsOfFile: path)!
            
            dataSouces.append((title, image))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hidden navigationBar
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
        navigationBar?.shadowImage = UIImage()
        
        view.addSubview(self.collectionView)
    }
}

// MARK: CollectionView Delegate
extension CenterViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSouces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CenterCell", for: indexPath) as! CenterCell
        
        cell.iconImageView.image = dataSouces[indexPath.item].image
        
        cell.titleLabel.text = dataSouces[indexPath.item].title
        
        return cell;
    }
    
    func itemHeight(at indexPath: IndexPath) -> CGFloat {
        let imgH = dataSouces[indexPath.item].image.size.height
        let imgW = dataSouces[indexPath.item].image.size.width
        
        let itemW = (view.bounds.size.width - 30)/2
        // itemW/imgW = itemH/imgH
        let itemH = itemW / imgW * imgH
        
        return itemH
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.2) {
            cell?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.2) {
            cell?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.description)
    
        switch indexPath.item {
        case 0:
            animator = BaseAnimator()
        case 1:
            animator = EaseInAnimator()
        case 2:
            animator = GradientAnimator()
        case 3:
            animator = MagicMoveAnimator()
        default:
            animator = MagicMoveAnimator()
        }
        navigationController?.delegate = animator as? UINavigationControllerDelegate
        navigationController?.pushViewController(TestViewController(), animated: true)
    }
}
