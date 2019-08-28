//
//  LoginViewController.swift
//  AutoLayoutDemo
//
//  Created by najmeh nasiriyani on 2019-08-21.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

     @IBOutlet weak var signUpButton: UIButton!
     @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        signInButton.addBorder()
        signUpButton.addBorder()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInBtnClicked(_ sender: UIButton) {
       let userName = userNameTextField.text!
        let password = passwordTextField.text!
        Auth.auth().signIn(withEmail: userName, password: password){
            [weak self] user, error in
            guard let strongself = self else{return}
            if let myuser = user{
                print("Login success for \(myuser)")
                self?.performSegue(withIdentifier: "goToHomePage", sender: self)
            }else {
                print("Login failed for \(userName)")
                return
            }
        }
        //performSegue(withIdentifier: "goToHomePage", sender: self)
        
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
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
extension UIButton{
    func addBorder(){
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.magenta.cgColor
        
    }
}
