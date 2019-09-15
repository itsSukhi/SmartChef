//
//  Choose_Category_Cell.swift
//  SmartChef
//
//  Created by osx on 10/10/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class Choose_Category_Cell: UITableViewCell {

    // *******Outlets ***********
    
    @IBOutlet weak var Choose_Btn: UIButton!
    @IBOutlet weak var Choose_Label: UILabel!

  @IBOutlet var catImage: UIImageView!
  @IBOutlet weak var designImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
