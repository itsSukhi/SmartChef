//
//  editHashTableViewCell.swift
//  SmartChef
//
//  Created by Mac Solutions on 19/12/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class editHashTableViewCell: UITableViewCell {

    @IBOutlet weak var designButton: UIButton!
    @IBOutlet weak var designLabel: UILabel!
    @IBOutlet weak var designImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
