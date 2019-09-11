//
//  storage.swift
//  AutoLayoutDemo
//
//  Created by najmeh nasiriyani on 2019-09-09.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import Foundation
import Firebase

class StorageManager {
    let ref = Storage.storage().reference()

    func uploadNewImage(userID: String, data:Data){
        let myRef = ref.child("images").child("profilePics/\(userID)")
        //let uplaodTask =
            myRef.putData(data, metadata: nil) { (metaData, error) in
            if error == nil{
                guard let metaData = metaData else{
                    return
                }
                let size = metaData.size
                let contnt = metaData.contentType
                print("The size is: \(size) and the type is: \(contnt.debugDescription)")
            }
        }
    }
    
    func downloadImage(imageName: String, completionBlock: @escaping (Bool,Data?)->Void){
        let myRef = ref.child("images").child("profilePics/\(imageName)")
        myRef.getData(maxSize: 2 * 1024 * 1024) { (data, error) in
            if error == nil{
                completionBlock(true, data!)
            } else {
                print(error!.localizedDescription + "      WHAAAAAATTTT    " + error.debugDescription)
                completionBlock(false, nil)
            }
        }
    }
}
