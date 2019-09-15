//
//  Review_Cell.swift
//  SmartChef
//
//  Created by osx on 18/09/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import Cosmos

class Review_Cell: UITableViewCell {

    // ****** Outlets ********
    
    @IBOutlet var Profile_Btn: UIButton!
    
    @IBOutlet weak var user_image: UIImageView!
    @IBOutlet var ratingView: CosmosView!
  @IBOutlet var userName: UILabel!
  
  @IBOutlet var timeLabel: UILabel!
  @IBOutlet var reviewTextLabel: UILabel!
  @IBOutlet var noOfReviewes: UILabel!
  @IBOutlet var noOfLikes: UILabel!
  @IBOutlet var reviewLike: UIImageView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    self.user_image.layer.cornerRadius = self.user_image.bounds.height/2
    self.user_image.clipsToBounds = true
    
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
