//
//  pendingSentCell.swift
//  SmartChef
//
//  Created by Mac Solutions on 06/04/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit

class pendingSentCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var designImage: UIImageView!
    @IBOutlet weak var designName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var tapped: ((pendingSentCell) -> Void)?
    @IBAction func accept(_ sender: Any) {
        tapped?(self)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
