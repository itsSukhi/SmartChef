//
//  chatHistoryCell.swift
//  SmartChef
//
//  Created by Mac Solutions on 30/03/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit

class chatHistoryCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var designImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var onlineImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
