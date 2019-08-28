//
//  RegisterViewController.swift
//  AutoLayoutDemo
//
//  Created by najmeh nasiriyani on 2019-08-26.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import UIKit


enum InputType:CaseIterable{
    case firstname
    case lastname
    case email
    case phone
    case password
}


class RegisterViewController: UIViewController, UITextFieldDelegate {

    var allFieldsAreOkay = false
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func registerButtonclicked(_ sender: UIButton) {
        allFieldsAreOkay = true
        for i in InputType.allCases{
            switch i{
            case .firstname: textFieldDidEndEditing(firstNameTextField)
            case .lastname: textFieldDidEndEditing(LastNameTextField)
            case .phone: textFieldDidEndEditing(phoneNumberTextField)
            case .email: textFieldDidEndEditing(emailTextField)
            case .password: textFieldDidEndEditing(passwordTextField)
            }
        }
        if allFieldsAreOkay{
            //showCorrectionAlert("All fields are Okay")
            addUserToFirebase()
        }
    }
    
    func addUserToFirebase(){
        //let signUpManager = FirebaseAuthManager()
        if let email = emailTextField.text, let password = passwordTextField.text {
            FirebaseAuthManager.createUser(email: email, password: password) {[weak self] (success) in
                guard let `self` = self else { return }
                var message: String = ""
                if (success) {
                    message = "User was sucessfully created."
                } else {
                    message = "There was an error."
                }
                 self.showCorrectionAlert(message)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        firstNameTextField.delegate = self
        LastNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.textColor = UIColor.black
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        var result: Bool = false
        if textField.hasText{
            switch textField{
            case emailTextField:
                result = validateEmail(inputText: emailTextField.text!)
            case firstNameTextField:
               result = validateFirstName(inputText: firstNameTextField.text!)
            case LastNameTextField:
              result = validateLastName(inputText: LastNameTextField.text!)
            case phoneNumberTextField:
                result = validatePhoneNumber(inputText:phoneNumberTextField.text!)
            case passwordTextField:
                result = validatePassword(inputText: passwordTextField.text!)
            default:
                break
            }
            if !result {
                allFieldsAreOkay = false
                textField.textColor = UIColor.red
                 DispatchQueue.main.async {
                    textField.becomeFirstResponder()
                }
            }
        }
    }
    
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
   
    
    func showCorrectionAlert(_ message: String){
        let myAlert = UIAlertController(title: "Checking the input fields", message: message, preferredStyle: .alert)
        let myAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        myAlert.addAction(myAction)
        present(myAlert, animated: true, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

/*JUNK CODE
 func didFinishEditing(_ textField: UITextField){
 // showAlert("Inside end editing")
 textField.resignFirstResponder()
 if textField.hasText{
 switch textField{
 case emailTextField:
 if !validateInput(type: .email, inputText: emailTextField.text!){emailTextField.textColor = UIColor.red}
 case firstNameTextField:
 if !validateInput(type: .firstname, inputText: firstNameTextField.text!){firstNameTextField.textColor = UIColor.red}
 case LastNameTextField:
 if !validateInput(type: .lastname, inputText: LastNameTextField.text!){LastNameTextField.textColor = UIColor.red}
 case phoneNumberTextField:
 if !validateInput(type: .phone, inputText: phoneNumberTextField.text!){phoneNumberTextField.textColor = UIColor.red}
 default:
 break
 }
 }
 
 }
 
 
 
 @IBAction func registerButtonclicked(_ sender: UIButton) {
 
 for i in InputType.allCases{
 switch i{
 case .firstname: validateInput(type: i, inputText: firstNameTextField.text!)
 case .lastname: validateInput(type: i, inputText: LastNameTextField.text!)
 case .phone:  validateInput(type: i, inputText: phoneNumberTextField.text!)
 case .email:  validateInput(type: i, inputText: emailTextField.text!)
 
 }
 }
 showCorrectionAlert("All fields are Okay")
 }
 
 
 
 
 
 
 
 func validateInput(type input: InputType, inputText: String) -> Bool {
 switch  input {
 case .firstname:
 let emailRegExp = "[A-Za-z]+"
 let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegExp)
 let result = emailPred.evaluate(with: inputText)
 if !result{
 
 //                showCorrectionAlert("First Name")
 //                DispatchQueue.main.async {
 self.firstNameTextField.becomeFirstResponder()
 }
 return result
 
 // }
 
 case .lastname:
 let emailRegExp = "[A-Za-z]+"
 let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegExp)
 let result = emailPred.evaluate(with: inputText)
 return result
 //  if !result{
 //                showCorrectionAlert("Last Name")
 //                DispatchQueue.main.async {
 //                    self.LastNameTextField.becomeFirstResponder()
 //                }
 // }
 case .phone:
 return inputText.count != 10
 //    {
 //                showCorrectionAlert("Phone Number")
 //                DispatchQueue.main.async {
 //                    self.phoneNumberTextField.becomeFirstResponder()
 //            }
 // }
 case .email:
 let emailRegExp = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
 let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegExp)
 let result = emailPred.evaluate(with: inputText)
 return result
 //            if !result{
 //                showCorrectionAlert("Email Address")
 //
 //                DispatchQueue.main.async {
 //                    self.emailTextField.becomeFirstResponder()
 //            }
 // }
 }
 }
 */