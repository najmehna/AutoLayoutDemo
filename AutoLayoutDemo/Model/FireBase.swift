//
//  FireBase.swift
//  AutoLayoutDemo
//
//  Created by najmeh nasiriyani on 2019-08-28.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import Foundation
//import FirebaseAuth
import Firebase

class FirebaseAuthManager {
    var ref : DatabaseReference! = Database.database().reference()
    let uuid = UUID().uuidString
    
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool, _ error: String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                print(user)
                completionBlock(true, nil)
            } else {
                let errormsg = error?.localizedDescription
                completionBlock(false, errormsg)
            }
        }
    }
    
    func addUserDetails(dataDict: [String:Any])-> Void{
        self.ref.child("users").childByAutoId().setValue(dataDict)
    }
    func addCourseDetails(dataDict: [String:Any])-> Void{
        self.ref.child("courses").childByAutoId().setValue(dataDict)
    }
    func signIn(userName: String , password:String, completionBlock: @escaping (_ success: Bool)-> Void){
        Auth.auth().signIn(withEmail: userName, password: password){(authResult, error)
            in
            if let user = authResult?.user{
                print(user)
                completionBlock(true)
            }else{completionBlock(false)
                
            }
        }
    }
    
    func getData() -> [String: Any]{
       // let uid = Auth.auth().currentUser?.uid
        var postDict : [String : Any] = [:]
        func setpostDict(dict: [String: Any]){
            postDict = dict
        }
        ref.child("users").observe(DataEventType.value, with: { (snapshot) in
            setpostDict(dict: snapshot.value as? [String : Any] ?? [:])
           // completionBlock(true)
           // print(postDict)
        })
        { (error) in
            print(error.localizedDescription)
            //completionBlock(false)
        }
    return postDict
    }
    func getUsersData(completionBlock:@escaping (_ success: Bool, _ snapshot: [String:Any])->Void){
        // let uid = Auth.auth().currentUser?.uid
        var postDict : [String : Any] = [:]

        ref.child("users").observe(DataEventType.value, with: { (snapshot) in
            postDict = snapshot.value as? [String : Any] ?? [:]
            completionBlock(true,postDict)
            // print(postDict)
        })
        { (error) in
            print(error.localizedDescription)
            completionBlock(false, postDict)
        }
    }

}
