//
//  Search_Profile_Cell.swift
//  SmartChef
//
//  Created by osx on 30/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import Cosmos
import TagListView

class Search_Profile_Cell: UITableViewCell {

    
    // *** Outlets *************
    
  @IBOutlet var noOflikesLabel: UILabel!
  @IBOutlet weak var Profile_Pic: UIButton!
    @IBOutlet weak var Follow_Btn: UIButton!
    @IBOutlet weak var Username: UILabel!
    @IBOutlet weak var Distance: UILabel!
    @IBOutlet weak var Flag_Image: UIImageView!
    @IBOutlet weak var Post_Btn: UIButton!
    @IBOutlet weak var Follower_Btn: UIButton!
    @IBOutlet weak var Description_label: UILabel!
    @IBOutlet weak var Location_Btn: UIButton!
    @IBOutlet weak var Location_Label: UILabel!
  
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet var profileTypeImageView: UIImageView!
  @IBOutlet var showCategoryLabel: UILabel!
  @IBOutlet var ratingView: CosmosView!
  @IBOutlet var tagVIew: TagListView!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    Profile_Pic.contentMode = .scaleToFill
    Profile_Pic.layer.masksToBounds = true
    
    self.userImage.layer.cornerRadius = self.userImage.layer.frame.size.width / 2
    self.userImage.contentMode = .scaleAspectFill
    self.userImage.clipsToBounds = true
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
