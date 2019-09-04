//
//  ValidateFuncs.swift
//  AutoLayoutDemo
//
//  Created by najmeh nasiriyani on 2019-08-28.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import Foundation

func validatePassword(inputText: String) -> Bool{
    var result = true
    if inputText.count > 7 , inputText.count < 17 {
        let emailRegExp = "[A-Z0-9a-z.-_]+"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegExp)
        result = emailPred.evaluate(with: inputText)
    } else {result = false}
    return result
}

func validateEmail(inputText: String) -> Bool{
    let emailRegExp = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegExp)
    let result = emailPred.evaluate(with: inputText)
    return result
}

func validateFirstName(inputText: String) -> Bool{
    let emailRegExp = "[A-Za-z]+"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegExp)
    return emailPred.evaluate(with: inputText)
}

func validateLastName(inputText: String) -> Bool{
    let emailRegExp = "[A-Za-z]+"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegExp)
    return emailPred.evaluate(with: inputText)
}

func validatePhoneNumber(inputText: String) -> Bool{
    return inputText.count == 10
}



