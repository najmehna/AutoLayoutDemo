//
//  BaseViewController.swift
//  AutoLayoutDemo
//
//  Created by najmeh nasiriyani on 2019-09-11.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    let lightNotif = Notification.Name(lightNotificationKey)
    let darkNotif = Notification.Name(darkNotificationKey)
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBAction func selectCharacterBtnClicked(_ sender: UIButton) {
        
        let selectionVC = storyboard?.instantiateViewController(withIdentifier: "SelectionViewController") as! SelectionViewController
        present(selectionVC, animated: true, completion: nil)
        
       /* ###
        let selectionVC = storyboard?.instantiateViewController(withIdentifier: "SelectionViewController") as! SelectionViewController
        selectionVC.selectCharDelegate = self
        present(selectionVC, animated: true, completion: nil)
 ### */
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        creeateNotifs()
        // Do any additional setup after loading the view.
    }
    
    func creeateNotifs(){
      
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.setImage(thecase:)), name: lightNotif, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setLabel(thecase:)), name: lightNotif, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setBackground(thecase:)), name: lightNotif, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.setImage(thecase:)), name: darkNotif, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setLabel(thecase:)), name: darkNotif, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setBackground(thecase:)), name: darkNotif, object: nil)
    }
    
    @objc func setImage(thecase: NSNotification){
        let isLight = thecase.name == lightNotif
        imageView.image = isLight ? UIImage(named: "Luke") : UIImage(named: "Darth")
    }
    @objc func setLabel(thecase: NSNotification){
        let isLight = thecase.name == lightNotif
        nameLabel.text = isLight ? "Luke SkyWalker" : "Darth Fader"
    }
    @objc func setBackground(thecase: NSNotification){
        let isLight = thecase.name == lightNotif
        view.backgroundColor = isLight ? .red : .green
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
/* ###
extension BaseViewController: selectCharacter{
    
    func didSelect(image: UIImage, name: String, color: UIColor) {
        imageView.image = image
        nameLabel.text = name
        view.backgroundColor = color
    }
    
    
 }
 ### */
