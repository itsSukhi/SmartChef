//
//  Location_Cell.swift
//  SmartChef
//
//  Created by osx on 04/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Location_Cell: UITableViewCell {

    
    @IBOutlet weak var Location_Label: UILabel!
    @IBOutlet weak var Location_Image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
