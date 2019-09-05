//
//  CoursesTableViewCell.swift
//  AutoLayoutDemo
//
//  Created by najmeh nasiriyani on 2019-09-04.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import UIKit

class CoursesTableViewCell: UITableViewCell {

    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var finalMarkLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setValues(course: Course){
        creditsLabel.text = String(course.credits)
        courseNameLabel.text = course.courseName
        finalMarkLabel.text = String(course.finalMark)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
