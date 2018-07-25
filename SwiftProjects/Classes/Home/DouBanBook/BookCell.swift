//
//  BookCell.swift
//  SwiftProjects
//
//  Created by Jason on 2018/7/25.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {

    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var bookTitle: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var subTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
