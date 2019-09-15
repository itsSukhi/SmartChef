//
//  Sound_Cell.swift
//  SmartChef
//
//  Created by osx on 12/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Sound_Cell: UITableViewCell {

    // ****** Outlets ******
    
    @IBOutlet weak var Sound_Label: UILabel!
    @IBOutlet weak var Sound_Label2: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
           }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
