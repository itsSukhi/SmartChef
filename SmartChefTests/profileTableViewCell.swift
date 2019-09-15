//
//  profileTableViewCell.swift
//  SmartChef
//
//  Created by Mac Solutions on 29/03/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit
import TagListView
import ActiveLabel
class profileTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      self.Heart_Btn2.titleLabel?.layer.shadowColor = UIColor.black.cgColor
      self.Heart_Btn2.titleLabel?.layer.shadowOffset = CGSize(width: 3, height: 5)
      self.Heart_Btn2.titleLabel?.layer.shadowRadius = 1.7
      self.Heart_Btn2.titleLabel?.layer.shadowOpacity = 0.46
      
      self.View_Btn2.titleLabel?.layer.shadowColor = UIColor.black.cgColor
      self.View_Btn2.titleLabel?.layer.shadowOffset = CGSize(width: 3, height: 5)
      self.View_Btn2.titleLabel?.layer.shadowRadius = 1.7
      self.View_Btn2.titleLabel?.layer.shadowOpacity = 0.46
      
      self.Comment_Btn2.titleLabel?.layer.shadowColor = UIColor.black.cgColor
      self.Comment_Btn2.titleLabel?.layer.shadowOffset = CGSize(width: 3, height: 5)
      self.Comment_Btn2.titleLabel?.layer.shadowRadius = 1.7
      self.Comment_Btn2.titleLabel?.layer.shadowOpacity = 0.46
      
      self.Days_Label.layer.shadowColor = UIColor.black.cgColor
      self.Days_Label.layer.shadowOffset = CGSize(width: 3, height: 5)
      self.Days_Label.layer.shadowRadius = 1.7
      self.Days_Label.layer.shadowOpacity = 0.46
      
      self.Profile_Image_View.layer.cornerRadius = self.Profile_Image_View.frame.size.width / 2
      self.Profile_Image_View.layer.masksToBounds = true
    }

    
    @IBOutlet weak var Loc_Image: UIImageView!
    @IBOutlet weak var Label: ActiveLabel!
    @IBOutlet weak var Profile_Image_View: UIImageView!
    @IBOutlet weak var Profile_Image: UIButton!
    @IBOutlet weak var Circle_Star_Btn: UIButton!
    @IBOutlet weak var Heart_Btn: UIButton!
    @IBOutlet weak var Pop_Up_Btn: UIButton!
    @IBOutlet weak var Message_Btn: UIButton!
    @IBOutlet weak var Share_Btn: UIButton!
    @IBOutlet weak var Location_Btn: UIButton!
    @IBOutlet weak var Username_Label: UILabel!
   
  @IBOutlet var tagListView: TagListView!
  @IBOutlet var tagVIewHeightCOnstraint: NSLayoutConstraint!
  
    
    @IBOutlet weak var Days_Label: UILabel!
    @IBOutlet weak var Show_Categories: UIButton!
    @IBOutlet weak var Image_View_id: UIImageView!
    @IBOutlet var Show_Category_Btn: UIButton!
    @IBOutlet weak var Location_Label: UILabel!
    @IBOutlet weak var Label_View: UILabel!
    @IBOutlet weak var Label_Heart: UILabel!
    @IBOutlet weak var Label_Comment: UILabel!
    
    // **** New Outlets **************
    
    @IBOutlet weak var View_Btn2: UIButton!
    @IBOutlet weak var Heart_Btn2: UIButton!
    @IBOutlet weak var Comment_Btn2: UIButton!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
