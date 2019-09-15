//
//  Notification_Cell.swift
//  SmartChef
//
//  Created by osx on 29/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Notification_Cell: UITableViewCell {

    // *** Outlets ****
    
    @IBOutlet weak var Done_Btn: UIButton!
    @IBOutlet weak var Notification_Btn: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
