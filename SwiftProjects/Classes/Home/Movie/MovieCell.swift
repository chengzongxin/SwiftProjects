//
//  MovieCell.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/7.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    // 海报
    @IBOutlet weak var picImageView: UIImageView!
    // 标题
    @IBOutlet weak var titleLabel: UILabel!
    // 流派
    @IBOutlet weak var genresLabel: UILabel!
    // 演员
    @IBOutlet weak var castLabel: UILabel!
    // 想看
    @IBOutlet weak var watchButton: UIButton!
    
    // DataModel
    var model: Subject? {
        didSet {
            let url = URL(string: (model?.images.large)!)!
            picImageView.setImageWith(url)
            
            titleLabel.text = model?.title
            
            var gernerStr = ""
            
            for gerner in (model?.genres)! {
                gernerStr.append(gerner + " ")
            }
        
            genresLabel.text = gernerStr
            
            var castStr = ""
    
            for cast in (model?.casts)! {
                castStr.append(cast.name + " ")
            }
            
            castLabel.text = castStr
        }
    }
    
    
    
}
