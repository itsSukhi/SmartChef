//
//  SearchedHashtagCell.swift
//  SmartChef
//
//  Created by SUKHWINDER SINGH on 19/02/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class SearchedHashtagCell: UITableViewCell {

    @IBOutlet weak var img:UIImage!
    @IBOutlet weak var hashtag:UILabel!
    @IBOutlet weak var count:UILabel!
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}//....
