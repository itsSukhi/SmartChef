//
//  SelectFeeed_Cell.swift
//  SmartChef
//
//  Created by osx on 28/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class SelectFeeed_Cell: UITableViewCell {
    
    @IBOutlet weak var Select_Feed_Label: UILabel!
    @IBOutlet weak var Select_Feed_Image: UIImageView!
    @IBOutlet weak var Select_Feed_Icon: UIImageView!
    
    
    // ***** Lets Go Label ****
    
    @IBOutlet weak var Lets_Go_Label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
