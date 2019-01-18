//
//  CenterViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/7/24.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit


class CenterViewController: UIViewController, WaterFlowLayoutDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var animator = Animator()
    
    
    lazy var dataSouces: [UIImage] = {
        var dataSouces: [UIImage] = []
        
        for i in 1...17 {
            let name = (i == 8 || i == 13 ? "huoying\(i).png" : "huoying\(i).jpg")
            let path = Bundle.main.path(forResource: name, ofType: nil)!
            let image = UIImage(contentsOfFile: path)!
            dataSouces.append(image)
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
            
            for i in 1...17 {
                let name = (i == 8 || i == 13 ? "huoying\(i).png" : "huoying\(i).jpg")
                let path = Bundle.main.path(forResource: name, ofType: nil)!
                let image = UIImage(contentsOfFile: path)!
                self.dataSouces.append(image)
            }
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(self.collectionView)
        // transition animator
        navigationController?.delegate = animator
    }
}

// MARK: CollectionView Delegate
extension CenterViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSouces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CenterCell", for: indexPath) as! CenterCell
        
        cell.iconImageView.image = dataSouces[indexPath.item]
        
        cell.titleLabel.text = String(indexPath.item)
        
        return cell;
    }
    
    func itemHeight(at indexPath: IndexPath) -> CGFloat {
        let imgH = dataSouces[indexPath.item].size.height
        let imgW = dataSouces[indexPath.item].size.width
        
        let itemW = (view.bounds.size.width - 30)/2
        // itemW/imgW = itemH/imgH
        let itemH = itemW / imgW * imgH
        
        return itemH
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.description)
        navigationController?.pushViewController(TestViewController(), animated: true)
    }
}
