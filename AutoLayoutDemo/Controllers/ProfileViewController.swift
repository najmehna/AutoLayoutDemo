//
//  HomeViewController.swift
//  AutoLayoutDemo
//
//  Created by najmeh nasiriyani on 2019-08-29.
//  Copyright © 2019 najmeh nasiriyani. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var profiles: [Profile] = Array()
    
    @IBOutlet weak var profileTableView: UITableView!
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        cell.setValues(profile: profiles[indexPath.row])
        
        return cell
    }
    func loadProfiles(){
        let myManager = FirebaseAuthManager()
        var myCell = Profile(name: "",email: "",phone: "", gender: true)
        myManager.getUsersData(completionBlock: {success , myDict in
            print(myDict)
            for i in myDict.keys{
                if let values = myDict[i] as? Dictionary<String, Any>{
                let myName = values["name"] as! String
                let myEmail = values["email"] as! String
                let myPhone = values["phoneNumber"] as! String
                let myGender = values["gender"] as! Bool
                myCell = Profile(name: myName, email: myEmail, phone: myPhone, gender: myGender)
                self.profiles.append(myCell)
                }
            }
            DispatchQueue.main.async {
                self.profileTableView.reloadData()
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTableView.delegate = self
        profileTableView.dataSource = self
        loadProfiles()

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
