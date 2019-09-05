//
//  UploadViewController.swift
//  AutoLayoutDemo
//
//  Created by najmeh nasiriyani on 2019-08-29.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import UIKit
import MobileCoreServices
//import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var courseTextField: UITextField!
    @IBOutlet weak var creditsTextField: UITextField!
    @IBOutlet weak var finalMarkTextField: UITextField!
    
    @IBOutlet weak var cameraButton: UIButton!{
        didSet{
            cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        }
    }

    @IBAction func uploadBtnClicked(_ sender: Any) {
        if validateInput(){
            let myDataManager = FirebaseAuthManager()
            let myDict = createDataDict()
        myDataManager.addCourseDetails(dataDict: myDict)
            let myAlert = UIAlertController(title: "Updating the database", message: "Data added", preferredStyle: .alert)
            let myAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            myAlert.addAction(myAction)
            present(myAlert, animated: true, completion: {
                 self.clearFields()
            })
        } else{
            showAlert("Please do not leave any fields empty.")
        }
    }
    @IBAction func takePicture(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.mediaTypes = [kUTTypeImage as String]
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated:true)
    }
    
    func clearFields(){
        courseTextField.text = ""
        creditsTextField.text = ""
        finalMarkTextField.text = ""
        DispatchQueue.main.async {
             self.courseTextField.becomeFirstResponder()
        }
       
    }
    func createDataDict()-> [String: Any]{
        let myDict = ["courseName" : courseTextField.text!, "courseCredit" : creditsTextField.text!, "finalMark" : finalMarkTextField.text!]
        return myDict
    }
    func validateInput() -> Bool{
        if courseTextField.hasText, creditsTextField.hasText, finalMarkTextField.hasText{
            return true
        }else{
            return false
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = (info[UIImagePickerController.InfoKey.editedImage] ?? info[UIImagePickerController.InfoKey.originalImage]) as? UIImage{
            uploadImageView.image = image
        }
        picker.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseTextField.delegate = self
        creditsTextField.delegate = self
        finalMarkTextField.delegate = self
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
        let myAlert = UIAlertController(title: "Checking the input fields", message: message, preferredStyle: .alert)
        let myAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        myAlert.addAction(myAction)
        present(myAlert, animated: true, completion: nil)
        
    }
}

