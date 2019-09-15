//
//  NotificationCell.swift
//  SmartChef
//
//  Created by Jagjeet Singh on 09/06/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {

  @IBOutlet var profileImage: UIImageView!
  
  @IBOutlet var notificationLabel: UILabel!
  
  @IBOutlet var timeLabel: UILabel!
  @IBOutlet var otherImage: UIImageView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
    self.profileImage.layer.cornerRadius = self.profileImage.layer.frame.size.width / 2
    self.profileImage.contentMode = .scaleAspectFill
    self.profileImage.clipsToBounds = true
    
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
