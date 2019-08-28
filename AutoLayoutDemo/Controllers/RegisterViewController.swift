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
    
}
class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
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
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        firstNameTextField.delegate = self
        LastNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       // showAlert("Inside end editing")
        textField.resignFirstResponder()
        if textField.hasText{
            switch textField{
            case emailTextField:
                   validateInput(type: .email, inputText: emailTextField.text!)
            case firstNameTextField:
                validateInput(type: .firstname, inputText: firstNameTextField.text!)
            case LastNameTextField:
                validateInput(type: .lastname, inputText: LastNameTextField.text!)
            case phoneNumberTextField:
                validateInput(type: .phone, inputText: phoneNumberTextField.text!)
                default:
                    break
                }
            }
        
        }
    
    func validateInput(type input: InputType, inputText: String){
        
        switch  input {
        case .firstname:
            let emailRegExp = "[A-Za-z]+"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegExp)
            let result = emailPred.evaluate(with: inputText)
            if !result{
                showCorrectionAlert("First Name")
                DispatchQueue.main.async {
                        self.firstNameTextField.becomeFirstResponder()
                    }
        
            }
            
        case .lastname:
            let emailRegExp = "[A-Za-z]+"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegExp)
            let result = emailPred.evaluate(with: inputText)
            if !result{
                showCorrectionAlert("Last Name")
                DispatchQueue.main.async {
                    self.LastNameTextField.becomeFirstResponder()
                }
            }
        case .phone:
            if inputText.count != 10{
                showCorrectionAlert("Phone Number")
                DispatchQueue.main.async {
                    self.phoneNumberTextField.becomeFirstResponder()
            }
            }
        case .email:
            let emailRegExp = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegExp)
            let result = emailPred.evaluate(with: inputText)
            if !result{
                showCorrectionAlert("Email Address")
                
                DispatchQueue.main.async {
                    self.emailTextField.becomeFirstResponder()
            }
            }
        }
    }
    
    func showCorrectionAlert(_ message: String){
        let myAlert = UIAlertController(title: "Please correct the information for:", message: message, preferredStyle: .alert)
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
