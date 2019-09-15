//
//  Select_Tag_Cell.swift
//  SmartChef
//
//  Created by osx on 19/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Select_Tag_Cell: UITableViewCell {

    // ****** Outlets ***********
    @IBOutlet var Tag_Label: UILabel!
    @IBOutlet weak var Tag_Image: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
