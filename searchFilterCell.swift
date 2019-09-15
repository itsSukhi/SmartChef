//
//  searchFilterCell.swift
//  SmartChef
//
//  Created by Mac Solutions on 24/03/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit

class searchFilterCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var designImage: UIImageView!
    @IBOutlet weak var designLabel: UILabel!
    
  @IBOutlet var circleImageView: UIImageView!
  override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
