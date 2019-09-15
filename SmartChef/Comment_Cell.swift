//
//  Comment_Cell.swift
//  SmartChef
//
//  Created by osx on 31/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Comment_Cell: UITableViewCell {

    // ******************
    var LikeHit = Int()
    @IBOutlet weak var Profile_Pic: UIButton!
    @IBOutlet weak var Heart_Btn: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var Heart_Label: UIButton!
    @IBOutlet weak var designImage: UIImageView!
    
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var profileImageView: UIButton!
  @IBOutlet var comentLabel: UILabel!
  @IBOutlet var timeLabel: UILabel!
  @IBOutlet var numberOfLikes: UIButton!
  
    override func awakeFromNib() {
          super.awakeFromNib()
      self.profileImageView.layer.cornerRadius = self.profileImageView.layer.frame.size.width / 2
      self.profileImageView.contentMode = .scaleAspectFill
      self.profileImageView.clipsToBounds = true
    
        self.userImage.layer.cornerRadius = self.userImage.layer.frame.size.width / 2
        self.userImage.contentMode = .scaleAspectFill
        self.userImage.clipsToBounds = true
        
    }

    @IBAction func Heart_Btn_Pressed(_ sender: Any) {
//        CheckSelection(Liked: LikeHit)
    }
    
    // **** Calling function Check Selection ******
    
    func CheckSelection(Liked: Int){
        if Liked == 0 {
            print("here Liked")
            Heart_Label.setImage(UIImage(named: "like"), for: .normal)
            LikeHit = 1
        }else{
            print("here UnLiked")
            Heart_Label.setImage(UIImage(named: "Liked"), for: .normal)
            LikeHit = 0
        }
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
