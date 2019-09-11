//
//  BaseViewController.swift
//  AutoLayoutDemo
//
//  Created by najmeh nasiriyani on 2019-09-11.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBAction func selectCharacterBtnClicked(_ sender: UIButton) {
        
        let selectionVC = storyboard?.instantiateViewController(withIdentifier: "SelectionViewController") as! SelectionViewController
        selectionVC.selectCharDelegate = self
        present(selectionVC, animated: true, completion: nil)
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
extension BaseViewController: selectCharacter{
    
    func didSelect(image: UIImage, name: String, color: UIColor) {
        imageView.image = image
        nameLabel.text = name
        view.backgroundColor = color
    }
    
    
}
