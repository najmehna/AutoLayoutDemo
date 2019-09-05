//
//  Profile.swift
//  AutoLayoutDemo
//
//  Created by najmeh nasiriyani on 2019-08-29.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import Foundation
import UIKit

struct Profile{
    var name: String
    var email: String
    var phone: String
    var gender: Bool
    //var image: UIImage
    func getDict()-> [String:Any]{
        let myDict: [String:Any] = ["name":self.name, "email":self.email, "phoneNumber" : self.phone, "gender": self.gender]
        return myDict
    }
//    init(myname: String, myemail: String, myphone: String, mygender: Bool){
//        name = myname
//       // image = myimage
//    }
}
struct Course{
    var courseName: String
    var credits: String
    var finalMark: String
    func getDict()->[String:Any]{
        let myDict: [String:Any] = ["courseName":self.courseName, "courseCredit": self.credits, "finalMark" : self.finalMark]
        return myDict
    }
}
