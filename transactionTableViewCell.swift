//
//  transactionTableViewCell.swift
//  SmartChef
//
//  Created by Mac Solutions on 08/01/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit

class transactionTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var designLabel: UILabel!
    @IBOutlet var coinsLabel: UILabel!
    @IBOutlet var dauyDateLabel: UILabel!
    @IBOutlet var designImage: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
