//
//  CustomTableViewCell.swift
//  AutoLayoutDemo
//
//  Created by najmeh nasiriyani on 2019-08-29.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
