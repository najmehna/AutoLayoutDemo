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
    
    static func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool, _ error: String?) -> Void) {
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
    static func addUserDetails(dataDict: [String:Any])-> Void{
        
    }
    static func signIn(userName: String , password:String, completionBlock: @escaping (_ success: Bool)-> Void){
        Auth.auth().signIn(withEmail: userName, password: password){(authResult, error)
            in
            if let user = authResult?.user{
                print(user)
                completionBlock(true)
            }else{completionBlock(false)
                
            }
        }
    }
}
