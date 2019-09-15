//
//  faqTableViewCell.swift
//  SmartChef
//
//  Created by Mac Solutions on 02/11/17.
//  Copyright © 2017 osx. All rights reserved.
//

import UIKit

class faqTableViewCell: UITableViewCell {

    @IBOutlet weak var firstViewLabel: UILabel!
    @IBOutlet weak var firstViewImgView: UIImageView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var secondViewTextView: UITextView!
    @IBOutlet weak var secondViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var line: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var showDetails = false{
        didSet{
            secondViewHeightConstraint.priority = showDetails ? 250 : 999
        }
    }
}
