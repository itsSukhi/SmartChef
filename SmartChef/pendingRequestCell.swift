//
//  pendingRequestCell.swift
//  SmartChef
//
//  Created by Mac Solutions on 04/04/18.
//  Copyright © 2018 osx. All rights reserved.
//

import UIKit

class pendingRequestCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var designImage: UIImageView!
    @IBOutlet weak var designName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var acceptTapped: ((pendingRequestCell) -> Void)?
    @IBAction func accept(_ sender: Any) {
        acceptTapped?(self)
    }
    var rejectTapped : ((pendingRequestCell) -> Void)?
    @IBAction func reject(_ sender: Any) {
        rejectTapped?(self)
    }
    
    var blockTapped : ((pendingRequestCell) -> Void)?
    @IBAction func block(_ sender: Any) {
        blockTapped?(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
