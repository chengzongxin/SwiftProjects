//
//  CenterCell.swift
//  SwiftProjects
//
//  Created by Jason on 2019/1/18.
//  Copyright © 2019 Jason. All rights reserved.
//

import UIKit

class CenterCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImageView.layer.cornerRadius = 10
        iconImageView.layer.masksToBounds = true
    }

}
