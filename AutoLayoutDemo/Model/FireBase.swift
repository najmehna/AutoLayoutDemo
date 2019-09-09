//
//  FireBase.swift
//  AutoLayoutDemo
//
//  Created by najmeh nasiriyani on 2019-08-28.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import Foundation
import Firebase

class FirebaseAuthManager {
    var ref : DatabaseReference! = Database.database().reference()
    //let uuid = UUID().uuidString
    
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
    
    func updateCourseDetails(dataDict: [String:Any], completionBlock: @escaping (_ success: Bool)->Void){

        self.ref.child("courses").queryOrdered(byChild: "courseName").queryEqual(toValue: dataDict["courseName"]).observeSingleEvent(of: .value) { (snapShot) in
            if let snap = snapShot.value as? [String:Any]{
                for each in snap{
                    let key = each.key
                    let name = each.value as! [String:Any]
                    print(name)
                    print("The key is :\(key)")
                }
            }
        }
    }
    
    func deleteCourse(At key: String,completionBlock: @escaping (_ success: Bool)->Void){
        self.ref.child("courses").child(key).removeValue { (error, dataRef) in
            if error != nil {
                completionBlock(false)
            }else{
                completionBlock(true)
            }
        }
    }
    
    func deleteProfile(At key: String,completionBlock: @escaping (_ success: Bool)->Void){
        self.ref.child("users").child(key).removeValue { (error, dataRef) in
            if error != nil {
                completionBlock(false)
            }else{
                completionBlock(true)
            }
        }
    }
    
    func signIn(userName: String , password:String, completionBlock: @escaping (_ success: Bool)-> Void){
        Auth.auth().signIn(withEmail: userName, password: password){(authResult, error) in
            if let user = authResult?.user{
                print(user)
                completionBlock(true)
            }else{completionBlock(false)
            }
        }
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
    
    func getCoursesData(completionBlock:@escaping (_ success: Bool, _ snapshot: [String:Any])->Void){
        // let uid = Auth.auth().currentUser?.uid
        var postDict : [String : Any] = [:]
        
        ref.child("courses").observe(DataEventType.value, with: { (snapshot) in
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
