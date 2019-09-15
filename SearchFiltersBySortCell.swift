//
//  SearchFiltersBySortCell.swift
//  SmartChef
//
//  Created by Jagjeet Singh on 30/06/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit

class SearchFiltersBySortCell: UITableViewCell {

  @IBOutlet var firstOptionButton: UIButton!
  @IBOutlet var secondOptionButton: UIButton!
  @IBOutlet var thirdOptionButton: UIButton!
  @IBOutlet var fourthOptionButton: UIButton!
  @IBOutlet var firstOptionLabel: UILabel!
  @IBOutlet var secondOptionLabel: UILabel!
  @IBOutlet var thirdOptionLabel: UILabel!
  @IBOutlet var fourthOptionLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
