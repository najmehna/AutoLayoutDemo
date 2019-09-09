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
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            postDict = snapshot.value as? [String : Any] ?? [:]
            completionBlock(true,postDict)
        }) { (error) in
            print(error.localizedDescription)
            completionBlock(false, postDict)
        }
    }
    
    func getCoursesData(completionBlock:@escaping (_ success: Bool, _ snapshot: [String:Any])->Void){
        // let uid = Auth.auth().currentUser?.uid
        var postDict : [String : Any] = [:]
        ref.child("courses").observeSingleEvent(of: .value, with: { (snapshot) in
            postDict = snapshot.value as? [String : Any] ?? [:]
            completionBlock(true,postDict)
        }) { (error) in
            print(error.localizedDescription)
            completionBlock(false, postDict)
        }
    }
    
    func nextLetter(_ letter: String) -> String? {
        
        // Check if string is build from exactly one Unicode scalar:
        guard let uniCode = UnicodeScalar(letter) else {
            return nil
        }
        return String(UnicodeScalar(uniCode.value + 1)!)
    }
    
    func searchUsersDataBase(for text: String, completionBlock:@escaping (_ success: Bool, _ snapshot: [String:Any])->Void){
        // let uid = Auth.auth().currentUser?.uid
        var postDict : [String : Any] = [:]
        var mytext = text
        var finish = String(text.last!)
        finish = nextLetter(finish)!
        mytext.removeLast()
        mytext = mytext + finish
        
        print("MY TEXT IS:>>>>>>: " + mytext)
        print("The search text ending is: "
            +  text + "\u{fffd}")
        //text + "\u{fffd}"
        ref.child("users").queryOrdered(byChild: "name").queryStarting(atValue: text).queryEnding(atValue: mytext).observeSingleEvent(of: .value, with: { (snapshot) in
            postDict = snapshot.value as? [String : Any] ?? [:]
            completionBlock(true, postDict)
        }) { (error) in
            print(error.localizedDescription)
            completionBlock(false, postDict)
        }
    }
    
    func searchCoursesDataBase(for text: String, completionBlock:@escaping (_ success: Bool, _ snapshot: [String:Any])->Void){
        // let uid = Auth.auth().currentUser?.uid
        var postDict : [String : Any] = [:]
        var mytext = text
        var finish = String(text.last!)
        finish = nextLetter(finish)!
        mytext.removeLast()
        mytext = mytext + finish
        
        print("MY TEXT IS:>>>>>>: " + mytext)
        print("The search text ending is: "
            +  text + "\u{fffd}")
        ref.child("courses").queryOrdered(byChild: "courseName").queryStarting(atValue: text).queryEnding(atValue: mytext).observeSingleEvent(of: .value, with: { (snapshot) in
            postDict = snapshot.value as? [String : Any] ?? [:]
            completionBlock(true, postDict)
        }) { (error) in
            print(error.localizedDescription)
            completionBlock(false, postDict)
        }
      }
}
