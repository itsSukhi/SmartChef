//
//  blockedTableViewCell.swift
//  SmartChef
//
//  Created by Mac Solutions on 03/04/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit

class blockedTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var designImage: UIImageView!
    @IBOutlet weak var designLabel: UILabel!
    
    var tapped: ((blockedTableViewCell) -> Void)?
    
    @IBAction func tappingCell(_ sender: Any) {
        tapped?(self)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
