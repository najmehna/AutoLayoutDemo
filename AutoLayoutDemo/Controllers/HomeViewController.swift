//
//  ViewController.swift
//  AutoLayoutDemo
//
//  Created by najmeh nasiriyani on 2019-08-20.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBAction func signOutBtnClicked(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage(username: UserDefaults.standard.string(forKey: "userName"))
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadImage(username: UserDefaults.standard.string(forKey: "userName"))
        
    }
    
    func loadImage(username: String?){
        if username != nil{
            let mystorageRef = StorageManager()
            let imageName = username! + ".jpg"
            mystorageRef.downloadImage(imageName: imageName) { (success, data) in
                if success{
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data!)
                    }
                }
            }
        }
    }
    
    
}

