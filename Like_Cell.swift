//
//  Like_Cell.swift
//  SmartChef
//
//  Created by osx on 30/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Like_Cell: UITableViewCell {

  @IBOutlet var userName: UILabel!
  @IBOutlet var timeLabel: UILabel!
  @IBOutlet var userImage: UIImageView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    self.userImage.layer.cornerRadius = self.userImage.layer.frame.size.width / 2
    self.userImage.clipsToBounds = true
    self.selectionStyle = .none

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
