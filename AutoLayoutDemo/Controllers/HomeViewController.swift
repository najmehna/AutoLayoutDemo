//
//  ViewController.swift
//  AutoLayoutDemo
//
//  Created by najmeh nasiriyani on 2019-08-20.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBAction func signOutBtnClicked(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

