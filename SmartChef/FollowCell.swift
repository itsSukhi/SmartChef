//
//  FollowCell.swift
//  SmartChef
//
//  Created by Jagjeet Singh on 26/05/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit
import Cosmos
class FollowCell: UITableViewCell {

  @IBOutlet var userImage: UIImageView!
  @IBOutlet var userName: UILabel!
  @IBOutlet var numberofLikes: UILabel!
  @IBOutlet var uploadedImages: UILabel!
  @IBOutlet var groupsLabel: UILabel!
  @IBOutlet var followButton: UIButton!
  @IBOutlet var ratingView: CosmosView!
  override func awakeFromNib() {
        super.awakeFromNib()

    self.followButton.layer.cornerRadius = 5
    self.followButton.clipsToBounds = true
    self.userImage.layer.cornerRadius = self.userImage.layer.frame.size.width / 2
    self.userImage.clipsToBounds = true

  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
