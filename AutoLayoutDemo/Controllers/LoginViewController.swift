//
//  LoginViewController.swift
//  AutoLayoutDemo
//
//  Created by najmeh nasiriyani on 2019-08-21.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {

    var allFieldsAreOkay = true
     @IBOutlet weak var signUpButton: UIButton!
     @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        
        signInButton.addBorder()
        signUpButton.addBorder()
        // Do any additional setup after loading the view.
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        var result: Bool = false
        if textField.hasText{
            switch textField{
            case userNameTextField:
                result = validateEmail(inputText: userNameTextField.text!)
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.textColor = UIColor.black
        return true
    }
    
    @IBAction func signInBtnClicked(_ sender: UIButton) {
        let myManager = FirebaseAuthManager()
        allFieldsAreOkay = true
        textFieldDidEndEditing(userNameTextField)
        textFieldDidEndEditing(passwordTextField)
        if allFieldsAreOkay{
            let userName = userNameTextField.text!
            let password = passwordTextField.text!
            DispatchQueue.global(qos: .userInteractive).async {
                myManager.signIn(userName: userName, password: password){
                    [weak self] (result) in
                    guard let `self` = self else{return}
                    if result{
                        print("Login success for \(userName)")
                        self.userNameTextField.resignFirstResponder()
                        self.passwordTextField.resignFirstResponder()
                        UserDefaults.standard.set(self.userNameTextField.text!, forKey: "username")
                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
                        self.performSegue(withIdentifier: "goToHomePage", sender: self)
                    }else {
                        self.showAlert("Log In failed for \(userName)")
                        print("Login failed for \(userName)")
                        DispatchQueue.main.async {
                            self.passwordTextField.becomeFirstResponder()
                            
                        }
                        return
                    }
                }
            }
        }else { showAlert("Please correct the information")}
        
        //performSegue(withIdentifier: "goToHomePage", sender: self)
        
        
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func showAlert(_ message: String){
        let myAlert = UIAlertController(title: "Signing In", message: message, preferredStyle: .alert)
        let myAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        myAlert.addAction(myAction)
        present(myAlert, animated: true, completion: nil)
        
    }
}
extension UIButton{
    func addBorder(){
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.magenta.cgColor
        
    }
}
