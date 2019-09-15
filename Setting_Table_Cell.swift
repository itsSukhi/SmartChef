//
//  Setting_Table_Cell.swift
//  SmartChef
//
//  Created by osx on 28/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Setting_Table_Cell: UITableViewCell {

    @IBOutlet weak var Setting_Label: UILabel!
    @IBOutlet weak var Setting_Image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
