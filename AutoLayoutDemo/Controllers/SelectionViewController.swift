//
//  SelectionViewController.swift
//  AutoLayoutDemo
//
//  Created by najmeh nasiriyani on 2019-09-11.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import UIKit

let lightNotificationKey = "co.seanallen.lightSide"
let darkNotificationKey = "co.seanallen.darkSide"

//I'm commenting out the code from delegation method ### to put in the notification method
class SelectionViewController: UIViewController {
    //### var selectCharDelegate: selectCharacter?
    let lightNotif = Notification.Name(lightNotificationKey)
    let darkNotif = Notification.Name(darkNotificationKey)
    

    @IBAction func LukeBtnClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: lightNotif, object: nil)
        dismiss(animated: true, completion: nil)

/* ###   let myName = "Luke"
        let myImage = UIImage(named: myName) ?? UIImage(named: "pinkBackground")!
        selectCharDelegate?.didSelect(image: myImage, name: myName, color: .red)
         dismiss(animated: true, completion: nil)  ### */
    }
    
    
    @IBAction func DarthBtnClicked(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: darkNotif, object: nil)
        dismiss(animated: true, completion: nil)
       /* ### let myName = "Darth"
        let myImage = UIImage(named: myName) ?? UIImage(named: "pinkBackground")!
        selectCharDelegate?.didSelect(image: myImage, name: myName, color: .green)
 dismiss(animated: true, completion: nil) ### */
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
