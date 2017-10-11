//
//  ItemCell.swift
//  RxSwiftLearning
//
//  Created by xuhaoran on 2017/10/10.
//  Copyright © 2017年 xuhaoran. All rights reserved.
//

import UIKit
import Reusable


class ItemCell: UITableViewCell,NibReusable {

    // MARK:- property
    
    @IBOutlet weak var picView: UIImageView!
    
    @IBOutlet weak var desLabel: UILabel!
    
    @IBOutlet weak var sourceLabel: UILabel!
    
    // MARK:- system
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension ItemCell{
    
    static func cellHeight() -> CGFloat{
        
        return 240
    }
    
}




