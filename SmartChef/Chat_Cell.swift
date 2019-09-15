//
//  Chat_Cell.swift
//  SmartChef
//
//  Created by osx on 26/08/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit
import TagListView
import ActiveLabel
class Chat_Cell: UITableViewCell {
    
    // ***** Outlets **************
    
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
    @IBOutlet weak var Caption_Btn: UIButton!
    @IBOutlet weak var View_Btn: UIButton!
    @IBOutlet weak var Like_Button: UIButton!
    @IBOutlet weak var Comment_Button: UIButton!
    @IBOutlet weak var main_Dishes_Label: UIButton!
    @IBOutlet weak var Dessers_Label: UIButton!
    @IBOutlet weak var Vegetarian_Label: UIButton!
    @IBOutlet weak var Soups_Label: UIButton!
    @IBOutlet weak var Salads_Label: UIButton!
    @IBOutlet weak var Days_Label: UILabel!
    @IBOutlet weak var Show_Categories: UIButton!
    @IBOutlet weak var Image_View_id: UIImageView!
    @IBOutlet var Show_Category_Btn: UIButton!
    @IBOutlet weak var Location_Label: UILabel!
    @IBOutlet weak var Label_View: UILabel!
    @IBOutlet weak var Label_Heart: UILabel!
    @IBOutlet weak var Label_Comment: UILabel!
    
    
    /// ******* See Categories Cell *****
    
    @IBOutlet var Fast_Food_Btn: UILabel!
    @IBOutlet var Asiian_Btn: UILabel!
    @IBOutlet var Home_Made_btn: UILabel!
    @IBOutlet var Drinks_bTN: UILabel!
    @IBOutlet var Sea_Foods: UILabel!
    @IBOutlet var Italian_Food: UILabel!
    @IBOutlet var Btn_7: UILabel!
    @IBOutlet var Btn_8: UILabel!
    @IBOutlet var Btn_9: UILabel!
    @IBOutlet var Btn_10: UILabel!
    @IBOutlet var Btn_11: UILabel!
    @IBOutlet var Btn_12: UILabel!
    
    // **** New Outlets **************
    
    @IBOutlet weak var View_Btn2: UIButton!
    @IBOutlet weak var Heart_Btn2: UIButton!
    @IBOutlet weak var Comment_Btn2: UIButton!
    

  @IBOutlet var tagView: TagListView!
  
  @IBOutlet var tagVIewHeightConstraint: NSLayoutConstraint!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    }
